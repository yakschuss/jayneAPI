# <@&455771078539739148> <@&434171221156823040> PC/CONSOLE
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

      if prefix == "M:"
        unless event.user.role?(352683696161030167)
          event.message.delete
          send_private_message("Uh, you're not a mod. Please don't use the mod tag to answer questions in #ask-a-t500.", event, bot)
        end
      elsif prefix == "A:"
        unless event.user.role?(455771078539739148) || event.user.role?(434171221156823040)
          event.message.delete
          send_private_message("You need to have the T500 role to answer questions in #ask-a-t500. Please message a moderator with proof in order to obtain the role.", event, bot)
          return
        end

        if event.user.role?(455771078539739148)
          event.message.create_reaction("💻")
        elsif event.user.role?(434171221156823040)
          event.message.create_reaction("🎮")
        end
      elsif prefix != "Q:"
        event.message.delete
        send_private_message("You must prefix all responses with Q: or A: in order to use #ask-a-t500.", event, bot)
      end
    end

    def send_private_message(message, event, bot)
      channel = bot.pm_channel(event.user.id)
      bot.send_message(channel, message)
    end
  end
end
