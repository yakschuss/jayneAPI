module PugBot
  module Commands
    class List

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def list_members
        return missing_arguments if missing_arguments?

        if pug.nil?
          return "There's no pug for that region, and you're not in any pugs. What are you even doing here?"
        end

        members
      end

      def pugs
        pugs = Pug.all

        if pugs
          meta_data = pugs.map(&:meta_data).join("\n")

          """
The current PUGs that are still being formed are for the following regions:
#{meta_data}
          """
        else
          "There are no PUGs, currently."
        end
      end

      private

      attr_accessor :event, :bot

      def region
        arguments[0]&.upcase
      end

      def pug_type
        arguments[1]&.downcase
      end

      def get_recent_pug
        if pug_type && region
          Pug.where(region: region, pug_type: pug_type).first
        else
          PugMember.where(ping_string: "<@#{event.user.id}>").first&.pug
        end
      end

      def pug
        @pug ||= get_recent_pug
      end

      def members
        members = pug.pug_members.pluck(:discord_tag)

        "The current members of the #{pug.region} #{pug.pug_type} pug are: \n #{members.join(",\n")} \n Captains: #{pug.captain_names.join("\n")} \n #{members.count}/12"
      end

      def missing_arguments
        "You're missing some info, I can't tell you anything about a pug if I don't know which pug you're talking about."
      end

      def missing_arguments?
        if !pug && arguments.length < 2
          true
        elsif !pug && arguments.length == 2
          false
        elsif pug
          false
        else
          true
        end
      end
    end
  end
end
