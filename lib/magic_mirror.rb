require 'json'
require 'faye'
require 'sinatra'
require 'tilt'

require "magic_mirror/version"
require "magic_mirror/mirror"

module MagicMirror

  def self.new
    @sinatra_root = File.expand_path('../..', __FILE__) if sinatra_root.nil?
    @command_cache = [] unless @command_cache
    Mirror.new
  end

  def self.sinatra_root=(value)
    @sinatra_root = value
  end

  def self.sinatra_root
    @sinatra_root
  end

  def self.command_cache
    # [ "RenderingCanvas.new('myCanvas', { title: 'trtl', minsize: [800, 600], is_test: true })",
    #   "RenderingcLine.new('myCanvas', 0, 0, 50, 50)"
    # ]
    @command_cache
  end

  def self.command_cache=(value)
    @command_cache=value
  end

end

# lol, hoisting problem in ruby???  thx sinatra...
require 'magic_mirror/sinatra_silver'
