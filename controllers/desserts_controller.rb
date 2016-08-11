require_relative '../lib/controller_base.rb'
require_relative '../models/dessert.rb'
require_relative '../models/bakery.rb'

class DessertsController < ControllerBase
  def create
    @dessert = Dessert.new(params["dessert"])

    if @dessert.save
      flash[:notice] = "New dessert added!"
      redirect_to "/bakery/#{@dessert.bakery_id}"
    else
      flash.now[:errors] = @dessert.errors
      render :new
    end
  end

  def destroy
    @dessert = Dessert.find(params["id"])

    @desserts.destroy
    redirect_to "/bakery/#{@dessert.bakery_id}"
  end

end
