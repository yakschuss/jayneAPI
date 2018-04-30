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
      list_members_command
      list_pugs_command
      remove_member_command
      clear_pug_command
      help_command
    end


    def test
      bot.command(:"test") do |event|
        "hi, what do you want"
      end
    end

    def help_command
      bot.command(:"help") do |event|
        Commands::HelpCommand.new(event, bot).process
      end
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

    def list_members_command
      bot.command(:"list-members") do |event|
        Commands::List.new(event, bot).list_members
      end
    end

    def list_pugs_command
      bot.command(:"list-pugs") do |event|
        Commands::List.new(event, bot).pugs
      end
    end

    def remove_member_command
      bot.command(:"remove-member") do |event|
        Commands::RemoveMember.new(event, bot).process
      end
    end

    def clear_pug_command
      bot.command(:"clear-pug") do |event|
        Commands::ClearPug.new(event, bot).process
      end
    end

  end
end
