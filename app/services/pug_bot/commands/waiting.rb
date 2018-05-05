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

        if members
          members.map(&:info).join("\n")
        else
          "No one waiting. If you're in the queue, but it thinks you're not, exit and rejoin."
        end
      end
    end
  end
end
