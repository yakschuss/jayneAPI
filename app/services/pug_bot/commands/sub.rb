module PugBot
  module Commands
    class Sub

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return no_voice_channel if user_not_in_voice?
        return missing_arguments if missing_arguments?
        return invalid_region if invalid_region?

        if @sub
          move_sub

          "Sub found, enjoy the game."
        else
          "There are no available subs for that SR range."
        end
      end

      private

      attr_accessor :event, :bot

      def sub
        @sub ||= QueueSpot.where(region: region, peak_sr: sr_range).order(created_at: :asc).first
      end

      def sr_range
        lower_bound = sr.to_i - 500
        upper_bound = sr.to_i + 500

        lower_bound..upper_bound
      end

      def region
        arguments[0]
      end

      def sr
        arguments[1]
      end

      def move_sub
        event.server.move(@sub.discord_id, event.user.voice_channel)
      end

      def no_voice_channel
        "I don't know what voice channel you're in! Go into your lobby and try again."
      end

      def user_not_in_voice?
        event.user.voice_channel.nil?
      end

      def invalid_region
        "I don't recognize that region. Try again?"
      end

      def invalid_region?
        !%(NA EU OCE PTR).include?(region)
      end

      def missing_sr
        "You're missing a few arguments. Check ?help to see the format."
      end

      def missing_arguments?
        arguments.length < 2
      end
    end
  end
end
