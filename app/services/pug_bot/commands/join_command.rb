module PugBot
  module Commands
    class JoinCommand
      def initialize(event)
        @event = event
      end

      def process
        "#{ping_string}, Your battlenet is #{battlenet}, you've registered for group type #{pug_type}, and you want to be a captain: #{captain}. Your discord is #{discord_tag}, for future reference."
      end


      private

      attr_accessor :event

      def arguments
        command = PREFIX + event.command.name.to_s
        content = event.content
        content.slice!(command)

        @arguments ||= event.content.strip.split("|")
      end

      def missing_arguments
        arguments.length < 2
      end

      def battlenet
        arguments[0]
      end

      def pug_type
        arguments[1]
      end

      def captain
        !!arguments[2]
      end

      def ping_string
        "<@#{event.user.id}>"
      end

      def discord_tag
        "#{event.user.username}##{event.user.discriminator}"
      end
    end
  end
end

