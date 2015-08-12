require 'faye'
require 'sinatra'

require "magic_mirror/version"
require "magic_mirror/mirror"

module MagicMirror

  def self.new
    @sinatra_root = File.expand_path('../..', __FILE__) if sinatra_root.nil?
    Mirror.new
  end

  def self.sinatra_root=(value)
    @sinatra_root = value
  end

  def self.sinatra_root
    @sinatra_root
  end


end

# lol, hoisting problem in ruby???
require 'magic_mirror/sinatra_silver'
