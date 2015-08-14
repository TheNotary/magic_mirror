module MagicMirror
  FAYE_PORT = 4555
  class Mirror
    def initialize

    end

    def init_servers
      threads = []
      # start sinatra
      threads << start_sinatra
      threads << start_faye

      threads
    end

    def start_sinatra
      Thread.new {
        SinatraSilver::App.run!
      }
    end

    def start_faye

      Thread.new {
        bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
        bayeux.listen(FAYE_PORT)
        run bayeux
      }

      #wait_until_faye_is_up
    end

    def get_faye_app

    end

    # sends messages through faye server to web interface
    def speak_into(msg)
      require 'net/http'
      channel = "/0001"

      message = {:channel => channel, :data => msg}
      uri = URI.parse("http://localhost:#{FAYE_PORT}/faye")
      begin
        Net::HTTP.post_form(uri, :message => message.to_json)
      rescue
        puts "failed to send message to faye server and thus webclient"
      end

    end

    def wait_until_faye_is_up
      while(true) do
        begin
          uri = URI.parse("http://localhost:#{FAYE_PORT}/faye")
          # Shortcut
          response = Net::HTTP.get_response(uri)
        rescue

        end
        sleep 1
        break if response and response.code == 400 and response.body == "Bad request"
      end
    end


  end
end
