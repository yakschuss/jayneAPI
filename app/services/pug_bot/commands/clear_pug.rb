module PugBot
  module Commands
    class ClearPug

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return disallowed if not_allowed?
        return missing_arguments if missing_arguments?

        pug = Pug.find_by(id: id)

        if pug
          channel_uuids = pug.channel_records.pluck(:channel_uuid)

          channels = event.server.voice_channels.select do |channel|
            channel_uuids.include?(channel.id.to_s)
          end

          channels.each do |channel|
            channel.delete
          end

          pug.destroy

          "Pug successfully cleared."
        else
          "Can't find a pug by with that ID. Check ?list-pugs for a list of pugs."
        end
      end

      private

      attr_accessor :event, :bot

      def id
        arguments[0]
      end

      def missing_arguments?
        arguments.length < 1
      end

      def missing_arguments
        "You need to include the ID of the PUG you wish to delete. It's the number found on the voice channels."
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
