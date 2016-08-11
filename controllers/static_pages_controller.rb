require_relative '../lib/controller_base.rb'

class StaticPagesController < ControllerBase
  def root
    render :root
  end

  def miniframe_orm
    render :miniframe_orm
  end

  def miniframe
    render :miniframe
  end
end
