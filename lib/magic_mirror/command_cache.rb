module MagicMirror

  class CommandCache < Array
    def <<(value)
      #puts "you pushed"
      MagicMirror.mirror.speak_into(value)
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




  end
end
