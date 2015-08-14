module MagicMirror

  class CommandCache < Array
    def <<(value)
      #puts "you pushed"
      MagicMirror.mirror.speak_into(value)
      super
    end

  end
end
