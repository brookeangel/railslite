require 'json'
require 'byebug'

class Session
  def initialize(req)
    cookie = req.cookies["_rails_lite_app"]
    @cookie = cookie.nil? ? {} : JSON.parse(req.cookies["_rails_lite_app"])
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def store_session(res)
    new_cookie = {}
    new_cookie[:path] ||= "/"
    new_cookie[:value] = @cookie.to_json
    res.set_cookie("_rails_lite_app", new_cookie)
  end
end
