# <@&455771078539739148> <@&434171221156823040> PC/CONSOLE
# <@&352683696161030167> MODS
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

      content = event.message.content

      if prefix == "M:"
        unless event.user.role?(481118818970632203)
          event.message.delete
          send_private_message("Uh, you're not a mod. Please don't use the mod tag to answer questions in #ask-an-expert. \n\n #{content}", event, bot)
        end
      elsif prefix == "A:"
        unless user_has_expert_role?(event)
          event.message.delete
          send_private_message("You need to have one of the expert roles listed in the channel description in order to answer questions in #ask-an-expert. Please message a moderator with proof in order to obtain the role. \n\n #{content}", event, bot)
          return
        end
          #
          # event.message.create_reaction("🎮")
          # event.message.create_reaction("💻")
      elsif prefix != "Q:"
        event.message.delete
        send_private_message("You must prefix all responses with Q: or A: in order to use #ask-an-expert. \n\n #{content}", event, bot)
      end
    end

    def send_private_message(message, event, bot)
      channel = bot.pm_channel(event.user.id)
      bot.send_message(channel, message)
    end

    def user_has_expert_role?(event)
      # coach
      event.user.role?(398229687605919744) ||
      # big boss
      event.user.role?(352683399812481026)
    end
  end
end
