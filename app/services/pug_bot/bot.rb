module PugBot
  class Bot
    def initialize(bot)
      @bot = bot
      define_commands
      define_event_handlers
    end

    def run
      bot.run :async
    end

    attr_accessor :bot

    private

    def define_commands
      register_command
    end

    def define_event_handlers
      join_pug_queue_event
      leave_pug_queue_event
    end

    def register_command
      bot.command(:"register") do |event|
        Commands::Register.new(event, bot).process
      end
    end

    def join_pug_queue_event
      bot.voice_state_update(channel: 442081250291744788) do |event|
        Events::HandleJoinQueue.new(event, bot).process
      end
    end

    def leave_pug_queue_event
      bot.voice_state_update(channel: nil, old_channel: 442081250291744788) do |event|
        Events::HandleLeaveQueue.new(event, bot).process
      end
    end
  end
end
