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
          create_queue_record
          check_full_grouping
        else
          remove_from_channel
          ping_to_register
        end
      end

      private

      attr_accessor :event, :bot

      def member
        @member ||= PugMember.find_by(discord_id: event.user.id)
      end

      def registered?
        !!member
      end

      def create_queue_record
        QueueSpot.find_or_create_by!(discord_id: event.user.id, peak_sr: member.peak_sr, region: member.region, captain: member.captain)
      end

      def check_full_grouping
        pug_lobby = get_lobby_together

        if !pug_lobby.empty?
          members = get_lobby_members(pug_lobby)
          @captains = captains(members)
          channels = create_voice_channels
          move_lobby_to_voice_channels(channels, members)
          ping_lobby_members(members)
          remove_queue_spot(pug_lobby)
        else
        end
      end

      def get_lobby_together
        lobby = QueueSpot.gm_game(member.region)
        @channel_name = "GM+ #{member.id}"
        return lobby if lobby.length == 12

        lobby = QueueSpot.diamond_plus_game(member.region)
        @channel_name = "Diamond+ #{member.id}"
        return lobby if lobby.length == 12

        lobby = QueueSpot.mixed_sr_game(member.region)
        @channel_name = "MixedSR #{member.id}"
        return lobby if lobby.length == 12

        return []
      end

      def create_voice_channels
        ["Blue", "Red"].map do |color|
          name = "#{@channel_name} #{color}"

          event.server.create_channel(
            name,
            2,
            parent: 442164165470060555,
            user_limit: 30,
          )
        end
      end

      def get_lobby_members(pug_lobby)
        PugMember.where(discord_id: pug_lobby.pluck(:discord_id))
      end

      def move_lobby_to_voice_channels(channels, lobby_members)
        lobby_members.each do |m|
          event.server.move(m.discord_id, channels.first)
        end
      end

      def ping_lobby_members(members)
        bot.send_message(440249322156851221, ping_message(members))
      end

      def ping_message(members)
        """
You are being pinged to play in #{@channel_name} PUG. Please report to #{@channel_name} Blue.\n

#{@captains.map(&:ping_string).join(" and ")}, you are this lobby's captains. #{@captains.first.discord_tag}, please create an invite only custom game with the competitive preset and begin inviting players once they confirm they are in-game.

The members below are present in the voice channel.

#{member_info(members)}
        """
      end

      def remove_queue_spot(pug_lobby)
        pug_lobby.map(&:destroy)
      end

      def member_info(members)
        members.map do |m|
          "#{m.ping_string} #{m.battlenet}"
        end.join("\n")
      end

      def captains(members)
        captains = members.where(captain: true).limit(2)

        if captains && captains == 2
          captains
        else
          members.order(peak_sr: :desc).limit(2)
        end
      end

      def remove_from_channel
        channel = event.server.create_channel(
          "temp",
          2,
          parent: 440427531183587338,
          user_limit: 30,
        )

        event.server.move(event.user.id, channel)

        channel.delete
      end

      def ping_to_register
        channel = bot.pm_channel(event.user.id)
        bot.send_message(channel, registration_message)
      end

      def registration_message
        """
Hi! First of all, welcome to PUGs! In order for you to play in pugs, you need to register for our system. It's pretty simple and easy to do.

All you have to do is type the following command in the #bot-commands channel!

    `?register BATTLETAG PEAKSR REGION CAPTAIN(optional)`

Make sure to replace the above with your information. If you wish to be a captain occasionally, be sure to add the word 'Captain' on the end of the command! 

Please note that Peak SR refers to the past three seasons, only.

Good luck, and welcome again!
        """
      end
    end
  end
end
