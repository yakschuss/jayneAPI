module PugBot
  module Commands
    class Need

      include PugBot::Arguments
      
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return missing_args if missing_args?
        return not_a_number unless number?
        return not_a_region unless region?
        return not_an_sr unless sr?

        bot.send_message(442768393087483908, need_ping)
      end

      attr_accessor :event, :bot

      def need_ping
        "#{number} players are needed for a PUG for the #{region} region, SR around #{sr}. Join PUG Queue if you're interested!"
      end

      def number
        arguments[0]
      end

      def region
        arguments[1].upcase
      end

      def sr
        arguments[2]
      end

      def missing_args
        "You're missing some info. Type ?help need to see how to use this command."
      end

      def missing_args?
        arguments.length < 3
      end

      def number?
        number.to_i.is_a?(Integer) && number <= 12
      end

      def sr?
        sr.to_i != 0 && ( sr >= 500 && sr <= 5000 )
      end

      def not_a_number
        "That's not a number. C'mon, yo."
      end

      def region?
        %w(NA EU OCE PTR).include?(region)
      end

      def not_a_region
        "That's not a region. C'mon, yo."
      end

      def not_an_sr
        "That's not an SR! C'mon, yo."
      end
    end
  end
end
