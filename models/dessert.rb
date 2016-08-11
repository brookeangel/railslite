require_relative '../orm_lite/lib/sql_object.rb'

class Dessert < SQLObject
  self.finalize!
  
  belongs_to "bakery"

  def errors
    @errors ||= []
  end

  def valid?
    unless bakery_id.present?
      errors << "Bakery id can't be blank"
      return false
    end

    unless type.present?
      errors << "Name can't be blank"
      return false
    end
    true
  end

  def inspect
    { type: type, bakery_id: bakery_id, id: id }.inspect
  end
end
