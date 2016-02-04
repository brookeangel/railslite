require_relative '../lib/controller_base.rb'
require_relative '../models/models_manifest.rb'

class DogsController < ControllerBase
  def create
    @dog = Dog.new(params["dog"])
    if @dog.save
      flash[:notice] = "Saved dog successfully"
      redirect_to "/dogs"
    else
      flash.now[:errors] = @dog.errors
      render :new
    end
  end

  def index
    @dogs = Dog.all
    render :index
  end

  def new
    @dog = Dog.new
    render :new
  end

  def show
    render :alksdfjklsdjafsdl
  end

end
