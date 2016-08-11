class Flash
  def initialize(req)
    cookie = req.cookies["_rails_lite_app_flash"]

    @later = {}
    @now = {}
    @now.merge!(JSON.parse(cookie)) if cookie
  end

  def now
    @now
  end

  def [](key)
    @now[key.to_s] || @later[key.to_s]
  end

  def []=(key, val)
    @now[key.to_s] = val
    @later[key.to_s] = val
  end

  def store_flash(res)
    new_cookie = {}
    new_cookie[:path] ||= "/"
    new_cookie[:value] = @later.to_json
    res.set_cookie("_rails_lite_app_flash", new_cookie)
  end
end
