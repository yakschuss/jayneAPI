module PugBot
  module Commands
    class Register

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return already_registered if member
        return missing_arguments_response if missing_arguments?

        PugMember.create!(
          discord_id: event.user.id,
          discord_tag: "#{event.user.username}##{event.user.discriminator}",
          battlenet: battlenet,
          peak_sr: peak_sr,
          region: region,
          captain: captain,
        )

        "Successfully registered. Welcome!"
      end

      private

      attr_accessor :event, :bot

      def member
        @member ||= PugMember.find_by(discord_id: event.user.id)
      end

      def already_registered
        "You're already registered! Just join the PUG Queue channel and you're good to go!"
      end

      def battlenet
        arguments[0]
      end

      def peak_sr
        arguments[1]
      end

      def region
        arguments[2].upcase
      end

      def captain
        !!arguments[3]
      end

      def missing_arguments?
        (arguments.length <= 3 && arguments.last == "Captain") || arguments.length < 3
      end

      def missing_arguments_response
        "You're missing some information. Check the format and try again."
      end

    end
  end
end
