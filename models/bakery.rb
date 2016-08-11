require_relative '../orm_lite/lib/sql_object.rb'

class Bakery < SQLObject
  self.finalize!

  has_many "desserts"

  def errors
    @errors ||= []
  end

  def valid?
    unless name.present?
      errors << "Name can't be blank"
      return false
    end

    unless location.present?
      errors << "Name can't be blank"
      return false
    end

    return true
  end

  def inspect
    { name: name, id: id }.inspect
  end
end
