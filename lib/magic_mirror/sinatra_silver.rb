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
    set :bind, '127.0.0.1'

    configure do
      disable :logging
    end

    get '/' do
      @command_cache = MagicMirror.command_cache.to_json
      @command_cache_length = MagicMirror.command_cache.length
      @command_cache_fast_evaluator = MagicMirror.command_cache.to_embedded_javascript
      erb :index # 'Hello world!'
    end

    get '/webworker.js' do
      erb :webworker
    end

    get '/missing_cache' do
      

    end
  end
end
