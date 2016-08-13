require_relative '../lib/controller_base.rb'
require_relative '../models/dessert.rb'
require_relative '../models/bakery.rb'

class DessertsController < ControllerBase
  def create
    @dessert = Dessert.new(params["dessert"])

    if @dessert.save
      flash[:notice] = ["New dessert added!"]
    else
      flash[:errors] = @dessert.errors
    end
    redirect_to "/bakeries/#{@dessert.bakery_id}"
  end

  def destroy
    @dessert = Dessert.find(params["id"])

    @desserts.destroy
    redirect_to "/bakeries/#{@dessert.bakery_id}"
  end

end
