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
    end

    def define_event_handlers
      join_pug_queue_event
      leave_pug_queue_event
    end

    def clear_pug_command
      bot.command(:"") do |event|
        Commands::ClearPug.new(event, bot).process
      end
    end

    def join_pug_queue_event
      bot.voice_state_update(channel: 394223728864657408) do |event|
        Events::HandleJoinQueue.new(event, bot).process
      end
    end

    def leave_pug_queue_event
      bot.voice_state_update(channel: nil, old_channel: 394223728864657408) do |event|
        Events::HandleLeaveQueue.new(event, bot).process
      end
    end
  end
end
