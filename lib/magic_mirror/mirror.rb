module MagicMirror
  FAYE_PORT = 4555
  class Mirror
    def initialize

    end

    def init_servers!
      Thin::Logging.silent = true
      print "\nActivating the Magic Mirror."

      @threads = []

      # start sinatra
      @threads << start_sinatra
      @threads << start_faye

      puts "\nThe Magic Mirror is Activated.  Navigate to http://127.0.0.1:4567"
      self
    end

    def start_sinatra
      queue = Queue.new # allows waiting for sinatra boot
      $stderr_backup = $stderr.dup
      $stderr.reopen("/dev/null", "w")

      Thread.new {
        SinatraSilver::App.run! do |server|
          queue.push("started") # tells caller thread to continue
        end
      }

      queue.pop # blocks until sinatra is booted
      print "."

      $stderr = $stderr_backup.dup
    end

    def start_faye
      queue = Queue.new # allows waiting for sinatra boot

      Thread.new {
        bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
        bayeux.listen(FAYE_PORT)
        bayeux.run!
        #run bayeux
      }

      #queue.pop # blocks until server is booted
      wait_until_faye_is_up
      print "."

    end

    def command_cache
      MagicMirror.command_cache
    end

    def command_cache=(value)
      MagicMirror.command_cache = value
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
        $stderr.puts "failed to send message to faye server and thus webclient"
      end

    end

    def wait_until_faye_is_up
      require 'net/http'
      while(true) do
        begin
          uri = URI.parse("http://localhost:#{FAYE_PORT}/")
          response = Net::HTTP.get_response(uri)
        rescue

        end
        break if response and response.code == "404" and response.body == "Sure you're not looking for /faye ?"
        sleep 0.1
      end
    end


  end
end
