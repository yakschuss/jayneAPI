class PugBot
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
    test
    # join_pug_command
    # leave_pug_command
    # request_sub_command
    # become_sub_command
    # list_command
    # delete_join_command
  end

  def test
    bot.command(:test) do |event|
      bot.send_message(422472661902426122, "I love #{event.user.name}")
    end
  end
end
