module PugBot
  module Commands
    class ClearPug
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return disallowed if not_allowed?
        return missing_arguments if missing_arguments?

        pug = Pug.find_by(pug_type: pug_type, region: region)

        if pug
          pug.destroy
          "Pug successfully cleared."
        else
          "Can't find a pug with that type/region combination. Check ?list-pugs for a list of pugs."
        end
      end

      private

      attr_accessor :event, :bot

      def region
        arguments[0].upcase
      end

      def pug_type
        arguments[1].downcase
      end

      def missing_arguments?
        arguments.length < 2
      end

      def missing_arguments
        "You haven't specified a region or pug type. Please check the ?list and specify."
      end

      def role_ids
        [
          421795021508050955,
          352683399812481026,
          352683696161030167,
        ]
      end

      def user_roles
        event.user.roles.map(&:id)
      end

      def not_allowed?
        (role_ids & user_roles).empty?
      end

      def disallowed
        "Yeaaahhh... this is awkward. You're not allowed to do that. Come back when you're cooler!"
      end
    end
  end
end
