require 'byebug'
class FormHelper
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    if req["_method"] &&
      if req["_method"]
        if req["_method"].upcase == "DELETE"
          req.env["REQUEST_METHOD"] = req["_method"].upcase
        elsif ["PATCH", "PUT"].include?(req["_method"].upcase)
          req.env["REQUEST_METHOD"] = "PUT"
        end
      end
    end

    app.call(env)
  end
end
