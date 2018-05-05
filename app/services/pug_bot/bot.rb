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
      sub_command
      region_command
      battlenet_command
      sr_command
      clear_lobbies_command
      help_command
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

    def sub_command
      bot.command(:"sub") do |event|
        Commands::Sub.new(event, bot).process
      end
    end

    def region_command
      bot.command(:"change-region") do |event|
        Commands::MemberInfo.new(event, bot).region_change
      end
    end

    def sr_command
      bot.command(:"change-sr") do |event|
        Commands::MemberInfo.new(event, bot).sr_change
      end
    end

    def battlenet_command
      bot.command(:"change-bnet") do |event|
        Commands::MemberInfo.new(event, bot).battlenet_change
      end
    end

    def clear_lobbies_command
      bot.command(:"clear-lobbies") do |event|
        Commands::ClearLobbies.new(event, bot).process
      end
    end

    def help_command
      bot.command(:"help") do |event|
        Commands::Help.new(event, bot).process
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
