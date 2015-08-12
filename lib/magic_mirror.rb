require 'faye'
require 'sinatra'

require "magic_mirror/version"
require "magic_mirror/mirror"

module MagicMirror

  def self.new
    Mirror.new
  end



end
