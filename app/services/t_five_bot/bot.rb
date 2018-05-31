module TFiveBot
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
      bot.message do |event|
        if event.channel.id == 434151072832028672
          moderate_t500_channel(event, bot)
        end
      end
    end

    def moderate_t500_channel(event, bot)
      prefix = event.message.to_s[0..1]

      puts prefix

      if prefix == "M:"
        unless event.user.role?(352683696161030167)
          event.message.delete
          event.send_message("Uh, you're not a mod.")
        end
      elsif prefix == "A:"
        unless event.user.role?(434171221156823040)
          event.message.delete
          event.send_message("You need to have the T500 role to answer questions in this channel. Please message a moderator with proof in order to obtain the role.")
        end
      elsif prefix != "Q:"
        event.message.delete
        event.send_message("You must prefix all responses with Q: or A: in order to use this channel.")
      end
    end
  end
end
