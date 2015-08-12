module MagicMirror
  class Mirror
    def initialize

    end

    def init_servers
      threads = []
      # start sinatra
      threads << Thread.new {
        SinatraSilver::App.run!
        puts "done"
      }

      threads
    end

  end
end
