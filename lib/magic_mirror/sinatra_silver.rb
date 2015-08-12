require 'tilt'

module SinatraSilver
  class App < Sinatra::Base
    set :root, MagicMirror.sinatra_root
    # set :app_file, MagicMirror.sinatra_root
    # set :views, MagicMirror.sinatra_root
    set :views, Proc.new { File.join(MagicMirror.sinatra_root, "lib", "views") }

    get '/' do
      erb :index # 'Hello world!'
    end
  end
end
