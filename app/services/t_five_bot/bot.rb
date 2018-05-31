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
      puts event.message
    end
  end
end
