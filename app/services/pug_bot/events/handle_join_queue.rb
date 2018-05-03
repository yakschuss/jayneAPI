module PugBot
  module Events
    class HandleJoinQueue
      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        puts "Entering: #{event.user.id}"

        if registered?
          # create_queue_record
          # handle_full_grouping
        else
          # remove_from_channel
          # ping_to_register
        end
      end

      private

      attr_accessor :event, :bot

      def handle_full_grouping
        # query waiting members
        # if 12 of one type
        # create voice channels
        # move to blue voice channel
        # ping all 12
        # remove waiting member registration (?)
        # else do nothing
        #
      end

      def create_queue_record
        QueueSpot.create!(discord_id: event.user.id, peak_sr: @member.peak_sr)
      end

      def member
        @member ||= PugMember.find_by(discord_id: event.user.id)
      end

      def registered?
        !!@member
      end

      def

      end
    end
  end
end
