require 'active_support/inflector'
require 'byebug'
require_relative 'db_connection'
require_relative 'searchable'
require_relative 'assoc_options'

class SQLObject
  extend Searchable
  extend Associatable

  def self.columns
    @cols ||= DBConnection.col_names(table_name).map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col_name|
      define_method(col_name) do
        attributes[col_name]
      end

      define_method("#{col_name.to_s}=") do |val|
        attributes[col_name] = val
      end
    end
  end

  def self.table_name=(table_name = nil)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    data = DBConnection.execute("SELECT * FROM #{table_name}")
    self.parse_all(data)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    id = id.to_i

    data = DBConnection.execute(<<-SQL, [id])
      SELECT *
      FROM #{table_name}
      WHERE id = $1
    SQL

    data.empty? ? nil : self.new(data.first)
  end

  def initialize(params = {})
    self.class.finalize!

    params.each do |key, val|
      unless self.class.columns.include?(key.to_sym)
        raise "unknown attribute '#{key}'"
      end

      self.send("#{key}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    param_syms = []

    columns.count.times do |i|
      param_syms << "$#{i + 1}"
    end

    obj = DBConnection.execute(<<-SQL, attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{param_syms.join(", ")})
      RETURNING
        *
    SQL
    self.id = obj[0]['id']
  end

  def update(new_attrs = {})

    new_attrs.each do |k, v|
      self.send("#{k}=", v)
    end

    num_cols = self.class.columns.count
    set_line = self.class.columns
      .map.with_index { |attr, idx| "#{attr} = $#{idx + 1}" }.join(", ")

    DBConnection.execute(<<-SQL, [*attribute_values, id])
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = $#{num_cols + 1}
    SQL

    return true if valid?
  end

  def valid?
    true
  end

  def save
    if valid?
      self.id ? update : insert
    end
  end

  def destroy
    DBConnection.execute(<<-SQL, [id])
      DELETE FROM
        #{self.class.table_name}
      WHERE
        #{self.class.table_name}.id = $1
    SQL
  end
end
