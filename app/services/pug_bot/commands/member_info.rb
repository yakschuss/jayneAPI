module PugBot
  module Commands
    class MemberInfo

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def sr_change
        return missing_first_arg if missing_first_arg?

        member = PugMember.find_by(discord_id: event.user.id)

        if member
          member.update_attributes(peak_sr: first_arg)
          "You've changed your peak SR to: #{first_arg}"
        else
          "You're not registered yet. Why don't you go register with the SR you're trying to tell me all about?"
        end
      end

      def region_change
        return missing_first_arg if missing_first_arg?

        member = PugMember.find_by(discord_id: event.user.id)

        if member
          member.update_attributes(region: first_arg)
          "You've changed your region to: #{first_arg}"
        else
          "You're not registered yet. Why don't you go register with the region you're trying to tell me all about?"
        end
      end

      private

      attr_accessor :event, :bot

      def first_arg
        arguments[0]
      end

      def missing_first_arg
        "You're missing some info. Check ?help and try again."
      end

      def missing_first_arg?
        arguments[0].nil?
      end

    end
  end
end
