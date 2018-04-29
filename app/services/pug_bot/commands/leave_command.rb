module PugBot
  module Commands
    class LeaveCommand
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        pug = Pug.find_by(pug_type: pug_type)

        if pug
          member = pug.pug_members.find_by(ping_string: ping_string)

          if member
            member.destroy
            "You have been successfully removed from the #{pug_type} PUG."
          else
            "You're not a part of that pug."
          end
        else
          "There's no pug currently going on."
        end
      end


      private

      attr_accessor :event, :bot

      def arguments
        command = PREFIX + event.command.name.to_s
        content = event.content
        content.slice!(command)

        @arguments ||= event.content.strip.split(" ")
      end

      def pug_type
        arguments[0].downcase
      end

      def ping_string
        "<@#{event.user.id}>"
      end
    end
  end
end
