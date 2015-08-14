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
    end

  end
end
