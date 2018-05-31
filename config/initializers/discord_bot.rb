#
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
