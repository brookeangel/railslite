require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require 'byebug'
require_relative './session'
require_relative './flash'
require_relative './authenticity_token'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    authenticate(req, res, route_params)
    @req = req
    @res = res
    @params = route_params.merge(req.params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    !!@already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Already rendered" if already_built_response?
    @already_built_response = true
    res.redirect(url, status = 302)
    session.store_session(res)
    # flash.store_flash(res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Already rendered" if already_built_response?
    @already_built_response = true
    res['Content-Type'] = content_type
    res.write(content)
    session.store_session(res)
    flash.store_flash(res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    file_name = "views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
    contents = File.read(file_name)
    template = ERB.new(contents)
    evaluated_template = template.result(binding)
    render_content(evaluated_template, 'text/html')
  end

  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  def auth_token
    @auth_token ||= AuthenticityToken.new(@req)
    token = @auth_token.form_authenticity_token
    @auth_token.save_token(res)
    token
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_built_response?
  end

  private

  def authenticate(req, res, route_params)
    return unless req.post? || req.patch?
    cookie = JSON.parse(req.cookies["_rails_lite_auth_token"])
    if !cookie || cookie["form_authenticity_token"] != req.params["form_authenticity_token"]
      raise "You do not have access."
    end
  end

end
