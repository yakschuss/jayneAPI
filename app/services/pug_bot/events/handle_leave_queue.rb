module PugBot
  module Events
    class HandleLeaveQueue
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        puts "Leaving: #{event.user.id}"
      end

      private

      attr_accessor :event, :bot
    end
  end
end
