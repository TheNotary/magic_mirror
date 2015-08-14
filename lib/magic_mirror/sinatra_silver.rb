require 'tilt'

module SinatraSilver
  class App < Sinatra::Base
    set :root, MagicMirror.sinatra_root
    # set :app_file, MagicMirror.sinatra_root
    # set :views, MagicMirror.sinatra_root
    set :views, Proc.new { File.join(MagicMirror.sinatra_root, "lib", "views") }
    #set :public_folder, Proc.new { File.join(MagicMirror.sinatra_root, "lib", "views") }
    #set :logging, false
    set :logging, false

    configure do
      disable :logging
    end

    get '/' do
      @command_cache = MagicMirror.command_cache.to_json
      erb :index # 'Hello world!'
    end
  end
end
