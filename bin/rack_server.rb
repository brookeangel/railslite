require 'rack'
require_relative '../lib/router'
require_relative '../lib/error_handler'
require_relative '../lib/static_assets'
require_relative '../lib/form_helper'

Dir["controllers/*.rb"].each do |file|
  require_relative "../" + file
end

router = Router.new

router.draw do
  get Regexp.new("^/$"), StaticPagesController, :root
  get Regexp.new("^/miniframe_orm$"), StaticPagesController, :miniframe_orm
  get Regexp.new("^/miniframe$"), StaticPagesController, :miniframe
  get Regexp.new("^/bakeries$"), BakeriesController, :index
  get Regexp.new("^/bakeries/new$"), BakeriesController, :new
  get Regexp.new("^/bakeries/(?<id>\\d+)$"), BakeriesController, :show
  put Regexp.new("^/bakeries/(?<id>\\d+)$"), BakeriesController, :update
  get Regexp.new("^/bakeries/(?<id>\\d+)/edit$"), BakeriesController, :edit
  delete Regexp.new("^/bakeries/(?<id>\\d+)$"), BakeriesController, :destroy
  post Regexp.new("^/bakeries$"), BakeriesController, :create
  post Regexp.new("^/desserts$"), DessertsController, :create
  delete Regexp.new("^/desserts/(?<id>\\d+)$"), DessertsController, :destroy
end

mini_frame_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

app = Rack::Builder.new do
  use ErrorHandler
  use Static
  use FormHelper
  run mini_frame_app
end.to_app

Rack::Server.start(
 app: app,
 Port: 3000
)
