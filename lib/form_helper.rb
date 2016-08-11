require 'byebug'
class FormHelper
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    if req["_method"] && ["patch", "delete", "put"].include?(req["_method"].downcase)
      req.env["REQUEST_METHOD"] = req["_method"].upcase
    end

    app.call(env)
  end
end
