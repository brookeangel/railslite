require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

class ErrorHandler
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    begin
      app.call(env)
    rescue Exception => e
      render_error(e)
    end
  end

  private

  def render_error(e)
    filepath = File.dirname(__FILE__) + "/templates/error.html.erb"
    contents = File.read(filepath)
    template = ERB.new(contents)
    evaluated_template = template.result(binding)

    ['500', {}, [evaluated_template]]
  end

  def source_file(e)
    abs_path = e.backtrace[0].split(":")[0]
    contents = File.read(abs_path)
  end
end
