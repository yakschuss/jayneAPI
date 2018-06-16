module GuessBot
  class Bot
    def initialize(bot)
      @bot = bot
      define_event
    end

    def run
      bot.run :async
    end

    attr_accessor :bot

    private

    def define_event
      bot.message(in: 444234790586023937) do |event|

        user_messages = event.channel.history(100).select do |message|
          message.author.id == event.message.author.id
        end

        if user_messages.count > 1
          event.message.delete
          send_private_message(stream_clips_only, event, bot)
        end
      end
    end

    def send_private_message(message, event, bot)
      channel = bot.pm_channel(event.user.id)
      bot.send_message(channel, message)
    end

    def stream_clips_only
      "You're sending too many clips to this channel. Please wait to send more."
    end

  end
end
