module PugBot
  module Commands
    class Info

      include PugBot::Arguments
      
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        if discord_tag
          member = PugMember.find_by(discord_tag: discord_tag)
        else
          member = PugMember.find_by(discord_id: event.user.id)
        end

        if member
          member.info
        else
          "I can't find you in the system, or that discord tag is invalid! Try again."
        end
      end

      attr_accessor :event, :bot

      def discord_tag
        arguments[0]
      end
    end
  end
end
