module PugBot
  module Commands
    class LeaveCommand

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        pug = Pug.find_by(pug_type: pug_type, region: region)

        if pug
          member = pug.pug_members.find_by(ping_string: ping_string)

          if member
            member.destroy
            "You have been successfully removed from the #{region}/#{pug_type} PUG."
          else
            "You're not a part of that pug."
          end
        else
          "Check the region/level, there might not be a pug going on or you might've spelled something incorrectly."
        end
      end

      private

      attr_accessor :event, :bot

      def pug_type
        arguments[1].downcase
      end

      def region
        arguments[0].upcase
      end

      def ping_string
        "<@#{event.user.id}>"
      end
    end
  end
end
