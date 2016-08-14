require './bin/rack_server'

mini_frame_app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MiniframeRouter.run(req, res)
  res.finish
end


use ErrorHandler
use Static
use FormHelper
run mini_frame_app
