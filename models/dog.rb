require_relative '../activerecordlite/lib/sql_object.rb'

class Dog < SQLObject

  def errors
    @errors ||= []
  end

  def valid?
    unless owner_id.present?
      errors << "Owner id can't be blank"
      return false
    end

    unless name.present?
      errors << "Name can't be blank"
      return false
    end
    true
  end

  def inspect
    { name: name, owner_id: owner_id }.inspect
  end
end
