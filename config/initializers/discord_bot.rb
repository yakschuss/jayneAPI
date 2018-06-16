class Discordrb::Bot
  def update_message(data)
    message = Discordrb::Message.new(data, self)
    return if message.author
    event = Discordrb::Events::MessageEditEvent.new(message, self)
    raise_event(event)
  end
end

# bot = Discordrb::Commands::CommandBot.new(
#   client_id: 439188930873524252,
#   token: ENV["DISCORD_PUG_BOT_TOKEN"],
#   prefix: "?",
# )
#
# PugBot::PREFIX = bot.prefix
#
# pugbot = PugBot::Bot.new(bot)
#
# pugbot.run
#

bot = Discordrb::Bot.new(
  client_id: 451760458601594880,
  token: ENV["DISCORD_T500_BOT_TOKEN"],
)

tfive_bot = TFiveBot::Bot.new(bot)

tfive_bot.run

bot = Discordrb::Bot.new(
  client_id: 456126136821350400,
  token: ENV["DISCORD_CLIP_BOT_TOKEN"],
)

clippy = ClipBot::Bot.new(bot)

clippy.run

gmsr_bot = Discordrb::Bot.new(
  client_id: 457686233179488256,
  token: ENV["DISCORD_GMSR_BOT_TOKEN"],
)

gmsr = GuessBot::Bot.new(gmsr_bot)

gmsr.run



