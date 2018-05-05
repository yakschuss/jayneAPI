module PugBot
  module Commands
    class Waiting

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        members = QueueSpot.all.map do |spot|
          spot.pug_member
        end

        members.map(&:info).join("\n")
      end
    end
  end
end
