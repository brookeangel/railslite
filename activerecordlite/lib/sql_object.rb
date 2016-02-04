require 'active_support/inflector'
require 'byebug'
require_relative 'db_connection'
require_relative 'searchable'
require_relative 'assoc_options'

class SQLObject
  extend Searchable
  extend Associatable

  def self.columns
    cols = DBConnection.execute2("SELECT * FROM #{table_name} LIMIT 0;").first
    @columns = cols.map do |col_name|
      col_name.to_sym
    end
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
    @table_name || self.to_s.tableize
  end

  def self.all
    data = DBConnection.execute("SELECT * FROM #{table_name}")
    self.parse_all(data)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    data = DBConnection.execute("SELECT * FROM #{table_name} WHERE id = ?", id)
    data.empty? ? nil : self.new(data.first)
  end

  def initialize(params = {})
    params.each do |key, val|
      raise "unknown attribute '#{key}'" unless self.class.columns.include?(key.to_sym)
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
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns
      .map { |attr| "#{attr} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    self.id ? update : insert
  end
end
