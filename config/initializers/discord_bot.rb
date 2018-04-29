
bot = Discordrb::Commands::CommandBot.new(
  client_id: 439188930873524252,
  token: ENV["DISCORD_BOT_TOKEN"],
  prefix: "p!",
)

PugBot::PREFIX = bot.prefix

pugbot = PugBot::Bot.new(bot)

pugbot.run
