module PugBot
  class Bot
    def initialize(bot)
      @bot = bot
      define_commands
    end

    def run
      bot.run :async
    end

    attr_accessor :bot

    private

    def define_commands
      join_pug_command
      leave_pug_command
      request_sub_command
      become_sub_command
      list_command
      # delete_join_command
      # help_command
    end

    def join_pug_command
      bot.command(:"join") do |event|
        Commands::JoinCommand.new(event, bot).process
      end
    end

    def leave_pug_command
      bot.command(:"leave") do |event|
        Commands::LeaveCommand.new(event, bot).process
      end
    end

    def request_sub_command
      bot.command(:"sub-request") do |event|
        Commands::SubRequest.new(event, bot).process
      end
    end

    def become_sub_command
      bot.command(:"sub") do |event|
        Commands::Sub.new(event, bot).process
      end
    end

    def list_command
      bot.command(:"list") do |event|
        Commands::List.new(event, bot).process
      end
    end
  end
end
