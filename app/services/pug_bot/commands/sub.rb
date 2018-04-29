module PugBot
  module Commands
    class Sub

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return missing_args     if missing_args?
        return invalid_region   if invalid_region?
        return invalid_pug_type if invalid_pug_type?
        return already_sub      if already_sub?

        create_sub

        response
      end

      private
attr_accessor :event, :bot

      def create_sub
        PugSub.create!(
          battlenet: battlenet,
          region: region,
          pug_type: pug_type,
          expiration_time: Time.current + 2.hours,
          ping_string: ping_string,
        )
      end

      def battlenet
        arguments[0]
      end

      def region
        arguments[1].upcase
      end

      def pug_type
        arguments[2].downcase
      end

      def ping_string
        "<@#{event.user.id}>"
      end

      def missing_args
        "You're missing some info there, bud"
      end

      def missing_args?
        arguments.length < 3
      end

      def invalid_region
        "That region isn't supported by our PUG system. Talk to the mods, I'm just a bot."
      end

      def invalid_pug_type
        "That pug type doesn't exist. Talk to the mods, I'm just a bot."
      end

      def response
        "#{ping_string}, You've been successfully added as a sub for a(n) #{region} #{pug_type} PUG. This registration is valid for two hours."
      end

      def invalid_region?
        !Pug::REGIONS.include?(region)
      end

      def invalid_pug_type?
        !Pug::PUG_TYPES.include?(pug_type)
      end

      def invalid_length?
        hours > 2
      end

      def already_sub
        "You're already registered as a sub for that PUG type, take it easy - you'll get your chance."
      end

      def already_sub?
        PugSub.where("pug_subs.expiration_time > ?", Time.current).where(ping_string: ping_string, pug_type: pug_type, region: region).exists?
      end
    end
  end
end
