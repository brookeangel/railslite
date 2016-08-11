require 'json'
require 'byebug'

class AuthenticityToken
  attr_reader :name

  def initialize(req)
    @name = "_rails_lite_auth_token"
    @data = {}
  end

  def form_authenticity_token
    @data["form_authenticity_token"] ||= SecureRandom::urlsafe_base64(16)
  end

  def save_token(res)
    new_cookie = {}
    new_cookie[:path] ||= "/"
    new_cookie[:value] = @data.to_json
    res.set_cookie(name, new_cookie)
  end
end
