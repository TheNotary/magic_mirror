require 'tilt'

module SinatraSilver
  class App < Sinatra::Base
    set :root, MagicMirror.sinatra_root
    # set :app_file, MagicMirror.sinatra_root
    set :views, Proc.new { File.join(MagicMirror.sinatra_root, "lib", "views") }
    #set :public_folder, Proc.new { File.join(MagicMirror.sinatra_root, "lib", "views") }
    set :logging, false
    set :bind, '127.0.0.1'

    configure do
      disable :logging
    end

    get '/' do
      @command_cache = MagicMirror.command_cache.to_json
      @command_cache_length = MagicMirror.command_cache.length
      @command_cache_fast_evaluator = MagicMirror.command_cache.to_embedded_javascript
      erb :index
    end

    get '/webworker.js' do
      erb :webworker
    end

    # There's a gap in the client's command cache, right after page load and
    # right before faye is connected, you will be missing commands.
    # This action is called when faye is connected to fill in the gap.
    get '/missing_cache' do
      l = params[:command_cache_length].to_i
      start_index = l-1

      MagicMirror.command_cache[start_index..-1].to_json
    end
  end
end
