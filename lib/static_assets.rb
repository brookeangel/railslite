require 'byebug'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'

class Static
  attr_reader :app, :root, :fileserver

  def initialize(app)
    @app = app
    @root = :public
    @fileserver = FileServer.new(root)
  end

  def call(env)
    req = Rack::Request.new(env)
    path = req.path

    if can_serve?(path)
      res = fileserver.call(env)
    else
      res = app.call(env)
    end

    res
  end

  private

  def can_serve?(path)
    path.index("/#{root}")
  end
end

class FileServer
  MIME_TYPES = {
    '.txt' => 'text/plain',
    '.jpg' => 'image/jpeg',
    '.jpeg' => 'image/jpeg',
    '.png' => 'image/png',
    '.zip' => 'application/zip',
    '.css' => 'text/css',
    '.js' => 'text/javascript'
  }

  def initialize(root)
    @root = root
  end

  def call(env)
    res = Rack::Response.new

    if file_found?(env)
      serve_file(file_name(env), res)
    else
      res.status = 404
    end

    res
  end

  private

  def serve_file(file_name, res)
    type = MIME_TYPES[File.extname(file_name)]
    res['Content-type'] = type
    file = File.read(file_name)
    res.write(file)
    res.finish
  end

  def file_name(env)
    req = Rack::Request.new(env)
    path = req.path
    dir = File.dirname(__FILE__)
    File.join(dir, "..", path)
  end

  def file_found?(env)
    file_name = file_name(env)
    File.exist?(file_name)
  end
end
