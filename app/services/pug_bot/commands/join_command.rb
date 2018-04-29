module PugBot
  module Commands
    class JoinCommand
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return invalid_pug_type_response if invalid_pug_type
        join_user_to_pug

        respond

        handle_full_pug if pug.full?
      end


      private

      attr_accessor :event, :bot

      def join_user_to_pug
        PugMember.create!(
          pug_id:      pug.id,
          captain:     captain,
          battlenet:   battlenet,
          discord_tag: discord_tag,
          ping_string: ping_string,
        )
      end

      def pug
        @pug ||= Pug.find_or_create_by!(pug_type: pug_type)
      end

      def user_response
        "#{ping_string}, You've been added to the #{pug.pug_type} PUG successfully. The total number of members so far is: #{pug.pug_members.count}/12. The total number of captains so far is #{pug.captains.count}/2. When the pug is full, everyone will be notified."
      end

      def arguments
        command = PREFIX + event.command.name.to_s
        content = event.content
        content.slice!(command)

        @arguments ||= event.content.strip.split(" ")
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

      def respond
        bot.send_message(event.channel.id, user_response)
      end

      def handle_full_pug
        bot.send_message(439500447930253312, pug.pug_ping)
        pug.destroy

        ""
      end

      def pug_ping
        pug.pug_members.each do |member|
          bot.send_message(439500447930253312, member.pug_ping)
        end
      end
    end
  end
end

