module ModBot
  module Commands
    class Ban

      def initialize(event, bot)
        @bot = event
        @event = event
      end

      def process
        return "You don't have permission to do that." unless commanding_user.can_ban_members?

        # register banning user
        # register banned user
        # create ban record
        # propagate ban to all servers
        # create log record
        # post to logs channel
      end

      private

      def commanding_user
        event.user
      end

      def commanding_discord_tag
        "#{commanding_user.username}##{commanding_user.discriminator}"
      end

      def create_ban_record
        BanRecord.create!(
          moderator: commanding_discord_tag,

        )
      end
    end
  end
end
