module PugBot
  module Commands
    class Info
      
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        member = PugMember.find_by(discord_id: event.user.id)

        if member
          member.info
        else
          "You're not registered. Register and try again."
        end
      end
    end
  end
end
