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


    def to_embedded_javascript
      string = ""

      string += "<script>"
      string += "window.command_cache = [];"

      self.each_slice(100) do |a|
        string += "z(#{a.to_json});"
      end

      string += "</script>"
      string
    end




  end
end
