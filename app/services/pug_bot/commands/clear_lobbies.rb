module PugBot
  module Commands
    class ClearLobbies

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        channels = event.server.voice_channels.select do |channel|
          channel.parent.id == 442164165470060555 && channel.users.count == 0
        end

        channels.map(&:delete)

        "Pug lobbies successfully cleared."
      end

      private

      attr_accessor :event, :bot
    end
  end
end
