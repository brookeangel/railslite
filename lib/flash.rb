require 'byebug'
class IndifferentAccessHash < Hash

  def [](key)
    super(key.to_s)
  end

  def []=(key, val)
    super(key.to_s, val)
  end
end

class Flash
  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]

    @data = IndifferentAccessHash.new
    @now = IndifferentAccessHash.new
    @now.merge!(JSON.parse(cookie)) if cookie
  end

  def now
    @now
  end

  def [](key)
    @now[key] || @data[key]
  end

  def []=(key, val)
    @now[key] = val
    @data[key] = val
  end

  def store_flash(res)
    new_cookie = {}
    new_cookie[:path] ||= "/"
    new_cookie[:value] = @data.to_json
    res.set_cookie("_rails_lite_app_flash", new_cookie)
  end
end
