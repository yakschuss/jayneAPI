
bot = Discordrb::Commands::CommandBot.new(
  client_id: 439188930873524252,
  token: ENV["DISCORD_BOT_TOKEN"],
  prefix: "p!",
)

pugbot = PugBot.new(bot)

pugbot.run
