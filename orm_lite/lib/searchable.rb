module Searchable
  def where(params)
    where_line = params.keys
                      .map.with_index { |key, i| "#{key} = $#{i + 1}" }
                      .join(" AND ")

    data = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(data)
  end

  def self.method_missing(method_name, *args)
    method_name = method_name.to_s

    if method_name.start_with?("find_by_")
      attribute_string = method_name[("find_by_".length)..-1]
      attribute_names = attribute_string.split("_and_")

      unless attribute_names.length == args.length
        raise "unexpected # of arguments"
      end

      search_conditions = {}
      attribute_names.each_index do |i|
        search_conditions[attribute_names[i]] = args[i]
      end

      self.where(search_conditions)
    else
      super
    end
  end
end
