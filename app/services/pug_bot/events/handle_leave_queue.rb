module PugBot
  module Events
    class HandleLeaveQueue
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        puts "Leaving: #{event.user.id}"

        spot = QueueSpot.find_by(discord_id: event.user.id)

        if spot
          spot.destroy
        end
      end

      private

      attr_accessor :event, :bot
    end
  end
end
