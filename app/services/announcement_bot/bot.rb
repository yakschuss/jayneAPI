#streamer role - 477571288991399936
module AnnouncementBot
  class Bot
    def initialize(bot)
      @bot = bot
      define_event
    end

    def run
      bot.run :async
    end

    attr_accessor :bot

    private

    def define_event
      bot.message do |event|
        if event.channel.id == 474293226170220544
          capture_announcement(event)
        end
      end
    end

    def capture_announcement(event)
      (id, username, link, description) = get_contents(event)

      member = event.server.member(id)

      if member.role?(352683399812481026)
        post_big_boss_message(username, link, description)
      elsif member.role?(474302144770605086)
        post_friends_message(username, link, description)
      else
        event.message.delete
      end
    end

    def get_contents(event)
      contents = event.message.to_s.split('~|~').map(&:strip)

      [
        contents.first,
        contents[1],
        contents[2],
        contents.last,
      ]
    end

    def post_big_boss_message(username, link, description)
      message = """
      @everyone! WOWIE! **#{username}** is now live on Twitch, streaming **#{description}**
      #{link}
      """
      bot.send_message(450894482733268992, message)
    end

    def post_friends_message(username, link, description)
      message = """
      Hey! **#{username}** is now live on Twitch, streaming **#{description}** \n
      <#{link}>
      """
      bot.send_message(450894482733268992, message)
    end

    def duplicate?(event)
      event.channel.history(10).select do |message|
        message.contents == event.message.contents
      end.any?
    end
  end
end
