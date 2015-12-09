require 'json'
require 'byebug'

class AuthenticityToken
  attr_reader :name

  def initialize(req)
    @name = "_rails_lite_auth_token"
    cookie = req.cookies[name]
    @now = cookie.nil? ? {} : JSON.parse(req.cookies[name])
    @later = {}
  end

  def correct_token?(submitted_token)
    submitted_token == @now['form_authenticity_token']
  end

  def form_authenticity_token
    @later["form_authenticity_token"] ||= SecureRandom::urlsafe_base64(16)
  end

  def save_token(res)
    new_cookie = {}
    new_cookie[:path] ||= "/"
    new_cookie[:value] = @later.to_json
    res.set_cookie(name, new_cookie)
  end

end
