require 'json'
require 'rack'
require 'thin'
require 'faye'
require 'sinatra'
require 'tilt'
require 'tilt/erb'

require "magic_mirror/version"
require "magic_mirror/mirror"
require "magic_mirror/command_cache"

module MagicMirror
  @@mirror = nil
  @@command_cache = CommandCache.new # unless @@command_cache

  def self.new
    @sinatra_root = File.expand_path('../..', __FILE__) if sinatra_root.nil?
    @@mirror = Mirror.new
  end

  def self.mirror
    @@mirror
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
    @@command_cache
  end

  def self.command_cache=(value)
    @@command_cache=value
  end

end


# lol, hoisting problem in ruby???  thx sinatra...
require 'magic_mirror/sinatra_silver'
