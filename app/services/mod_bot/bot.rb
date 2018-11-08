module ModBot
  class Bot
    def initialize(bot)
      @bot = bot
      define_commands
      # define_event_handlers
    end

    def run
      bot.run :async
    end

    attr_accessor :bot

    private

    def define_commands
      ban_command
    end

    def define_event_handlers
    end

    def ban_command
      bot.command(:"ban") do |event|
        Commands::Ban.new(event, bot).process
      end
    end
  end
end
