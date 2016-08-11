require_relative '../lib/controller_base.rb'

class BakeriesController < ControllerBase
  def create
    @bakery = Bakery.new(params["bakery"])

    if @bakery.save
      flash[:notice] = "New bakery added!"
      redirect_to "/bakeries"
    else
      flash.now[:errors] = @bakery.errors
      render :new
    end
  end

  def index
    @bakeries = Bakery.all
    render :index
  end

  def new
    @bakery = Bakery.new
    render :new
  end

  def edit
    @bakery = Bakery.find(params["id"])
    render :edit
  end

  def update
    @bakery = Bakery.find(params["id"])

    if @bakery.update(params["bakery"])
      flash[:notice] = "Bakery updated!"
      redirect_to "/bakeries/#{@bakery.id}"
    else
      flash.now[:errors] = @bakery.errors
      render :new
    end
  end

  def show
    @bakery = Bakery.find(params["id"])
    @desserts = @bakery.desserts

    render :show
  end

  def destroy
    @bakery = Bakery.find(params["id"]).destroy

    redirect_to "/bakeries"
  end
end
