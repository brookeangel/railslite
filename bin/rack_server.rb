require 'rack'
require_relative '../lib/router'
require_relative '../controllers/controller_manifest.rb'
require_relative '../lib/error_handler'
require_relative '../lib/static_assets'

router = Router.new

router.draw do
  get Regexp.new("^/$"), DogsController, :index
  get Regexp.new("^/dogs$"), DogsController, :index
  get Regexp.new("^/dogs/show$"), DogsController, :show
  get Regexp.new("^/dogs/new$"), DogsController, :new
  get Regexp.new("^/dogs/(?<id>\\d+)$"), DogsController, :show
  post Regexp.new("^/dogs$"), DogsController, :create
end


railslite_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ErrorHandler
  use Static
  run railslite_app
end.to_app

Rack::Server.start(
 app: app,
 Port: 3000
)
