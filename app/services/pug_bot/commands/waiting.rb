module PugBot
  module Commands
    class Waiting

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        QueueSpot.all.map do |spot|
          spot&.pug_member&.discord_tag
        end.compact.join("\n")
      end
    end
  end
end
