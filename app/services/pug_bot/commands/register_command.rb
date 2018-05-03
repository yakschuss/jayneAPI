module PugBot
  module Commands
    class RegisterCommand

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return already_registered if member

        PugMember.create!(
          discord_id: event.user.id,
          dicord_tag: "#{event.user.username}##{event.user.discriminator}",
          battlenet: battlenet,
          peak_sr: peak_sr,
          region: region,
        )

        "Succesfully registed. Welcome!"
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
      end

      def peak_sr
      end

      def region
      end


    end
  end
end
