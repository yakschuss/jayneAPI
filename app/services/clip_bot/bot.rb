module ClipBot
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
      bot.message(in: 352681959345881098) do |event|
        if event.message.content.include?("https")

          edit_event = bot.add_await!(
            Discordrb::Events::MessageEditEvent,
            id: event.message.id,
            timeout: 30
          )

          unless edit_event.nil?
            stream = edit_event.message.embeds.first.title.split(" ")[0].strip.to_s

            puts "STREAM: #{stream}"

            if stream.downcase != "jayne" && stream.downcase != "deophest"
              event.message.delete
              send_private_message(stream_clips_only, event, bot)
            end
          end
        end
      end
    end


    def send_private_message(message, event, bot)
      channel = bot.pm_channel(event.user.id)
      bot.send_message(channel, message)
    end

    def stream_clips_only
      "This channel is for Jayne and Deo clips only. Please post links in our #links channel."
    end

  end
end


