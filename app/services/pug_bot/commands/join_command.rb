module PugBot
  module Commands
    class JoinCommand
      def initialize(event)
        @event = event
      end

      def process
        return invalid_pug_type_response if invalid_pug_type
        join_user_to_pug

        generate_response
      end


      private

      attr_accessor :event

      def join_user_to_pug
        PugMember.create!(
          pug_id: pug.id,
          ping_string: ping_string,
          discord_tag: discord_tag,
          battlenet: battlenet,
          captain: captain,
        )
      end

      def pug
        @pug ||= Pug.find_or_create_by!(pug_type: pug_type)
      end

      def generate_response

      end

      def arguments
        command = PREFIX + event.command.name.to_s
        content = event.content
        content.slice!(command)

        @arguments ||= event.content.strip.split("|")
      end

      def missing_arguments
        arguments.length < 2
      end

      def battlenet
        arguments[0]
      end

      def pug_type
        arguments[1].downcase
      end

      def captain
        !!arguments[2]
      end

      def ping_string
        "<@#{event.user.id}>"
      end

      def discord_tag
        "#{event.user.username}##{event.user.discriminator}"
      end

      def invalid_pug_type_response
        "That pug type doesn't currently exist. Talk to a mod or pug staff member about different pug classifications."
      end

      def invalid_pug_type
        !Pug::PUG_TYPES.include?(pug_type)
      end
    end
  end
end

