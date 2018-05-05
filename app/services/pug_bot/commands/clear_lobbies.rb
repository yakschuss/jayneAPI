module PugBot
  module Commands
    class ClearLobbies

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process

      end

      private

      attr_accessor :event, :bot
    end
  end
end
