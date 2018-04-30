module PugBot
  module Commands
    class JoinCommand

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        return missing_arguments_response if missing_arguments?
        return invalid_pug_type_response if invalid_pug_type?
        return invalid_region_response if invalid_region?
        return duplicate_member_response if duplicate_member?

        @pug = PugBot::CreatePug.new(attributes, event).run!

        respond

        handle_full_pug if pug.full?
      end


      private

      attr_accessor :event, :bot, :pug

      def attributes
        {
          region:      region,
          captain:     captain,
          pug_type:    pug_type,
          battlenet:   battlenet,
          ping_string: ping_string,
          discord_tag: discord_tag,
        }
      end

      def user_response
        "#{ping_string}, You've been added to the #{pug.region} #{pug.pug_type} PUG successfully. The total number of members so far is: #{pug.pug_members.count}/12. The total number of captains so far is #{pug.captains.count}/2. When the pug is full, everyone will be notified."
      end

      def missing_arguments?
        (arguments.length <= 3 && arguments.last == "Captain") || arguments.length < 3
      end

      def missing_arguments_response
        "You're missing some information. Check the format and try again."
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

      def captain
        !!arguments[3]
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

      def invalid_pug_type?
        !Pug::PUG_TYPES.include?(pug_type)
      end

      def invalid_region_response
        "What region is that? WHERE THE HELL ARE YOU FROM?!"
      end

      def invalid_region?
        !Pug::REGIONS.include?(region)
      end

      def duplicate_member_response
        "You're already a member of that PUG. Give someone else a shot, alright?"
      end

      def duplicate_member?
        types_and_regions = PugMember.where(ping_string: ping_string).map do |member|
          [member.pug.pug_type, member.pug.region]
        end

        types_and_regions.include?([pug_type, region])
      end

      def respond
        bot.send_message(event.channel.id, user_response)
      end

      def handle_full_pug
        bot.send_message(440249322156851221, pug.pug_ping)
      end
    end
  end
end

