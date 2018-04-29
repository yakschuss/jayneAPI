module PugBot
  module Arguments
    def arguments
      command = PREFIX + event.command.name.to_s
      content = event.content
      content.slice!(command)

      @arguments ||= event.content.strip.split(" ")
    end
  end
end
