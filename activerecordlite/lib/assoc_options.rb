class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      foreign_key: "#{name.to_s.underscore}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase
    }

    defaults.merge(options).each do |key, val|
      self.send("#{key}=", val)
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: "#{self_class_name.to_s.underscore}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.singularize.camelcase
    }

    defaults.merge(options).each do |key, val|
      self.send("#{key}=", val)
    end
  end
end

module Associatable

  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      key = self.send(options.foreign_key)

      options
        .model_class
        .where(options.primary_key => key)
        .first
    end
  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      key = self.send(options.primary_key)

      options.model_class.where(options.foreign_key => key)
    end
  end

  def has_one_through(name, through_name, source_name)

    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      primary_key = self.send(through_options.primary_key)

      data = DBConnection.execute(<<-SQL)
        SELECT
          c.*
        FROM
          #{self.class.table_name} AS a
        JOIN
          #{through_options.table_name} AS b
            ON b.#{through_options.primary_key} = a.#{through_options.foreign_key}
        JOIN
          #{source_options.table_name} AS c
            ON b.#{source_options.foreign_key} = c.#{source_options.primary_key}
        WHERE
          a.#{through_options.primary_key} = #{primary_key}
      SQL

      source_options.model_class.new(data.first)
    end
  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end
