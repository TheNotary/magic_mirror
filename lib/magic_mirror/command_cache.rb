module MagicMirror

  class CommandCache < Array
    attr_accessor :buffer

    def initialize
      @buffer = []
      @buffer_flush_point = 2000
      @last_command_at = Time.now

      @mutex = Mutex.new

      @timeout_thread = Thread.new {
        while true
          @mutex.synchronize {
            MagicMirror.command_cache.transmit_buffer!
          }
          Thread.stop
          sleep 1
        end
      }

      super
    end

    def <<(value)
      @buffer << value

      transmit_buffer_if_ripe
      queue_buffer_to_be_transmitted if @buffer.length > 0 and @buffer.length < 5

      super
    end


    def reset
      self.clear
      MagicMirror.mirror.speak_into("MagicMirror.clearCommandCache();")
      self
    end

    # what if I cached this value?...
    def to_embedded_javascript
      string = ""

      string += "<script>"

      time_offset = 40
      self.each_slice(100) do |a|
        string += "setTimeout(function(){"
        string += "z(#{a.to_json});"
        if time_offset == 40
          string += "}, #{0});"
          time_offset+=5
        else
          string += "}, #{time_offset+=5});"
        end
      end

      string += "</script>"
      string
    end

    def transmit_buffer_if_ripe
      if time_to_send_commands_through_mirror? or we_have_a_light_message_load?
        transmit_buffer!
      end
      @last_command_at = Time.now
    end

    def transmit_buffer!
      MagicMirror.mirror.speak_into(@buffer.join) if @buffer.length > 0
      @buffer = []
    end

    def time_to_send_commands_through_mirror?
      @buffer.length >= @buffer_flush_point
    end

    def we_have_a_light_message_load?
       (Time.now - @last_command_at) > 0.10
    end

    # This method goes wrong because it can fire at the same time
    # magic_mirror.speak_into may be firing....
    def queue_buffer_to_be_transmitted
      @timeout_thread.wakeup
    end

    def needs_flush?
      @buffer.length >= 0
    end





  end
end
