module PugBot
  module Commands
    class SubRequest

      include PugBot::Arguments

      def initialize(event, bot)
        @event = event
        @bot = bot
      end

      def process
        remove_old_subs

        if sub
          channel = bot.pm_channel(sub.discord_id)
          bot.send_message(channel, sub_ping)
          battlenet = sub.battlenet
          remove_sub

          "<@#{event.user.id}>, The battlenet for the sub is #{battlenet}."
        else
          "There are no subs registered. Sucks to be you!"
        end
      end

      private

      def region
        arguments[0].upcase
      end

      def pug_type
        arguments[1].downcase
      end

      def pug
        Pug.unfilled.where(
          pug_type: pug_type, region: region
        ).first
      end

      def sub
        @sub ||= PugSub.where("pug_subs.expiration_time > ?", Time.current).
          where(region: region, pug_type: pug_type).order(created_at: :asc).first
      end

      def remove_old_subs
        PugSub.where("pug_subs.expiration_time < ?", Time.current).delete_all
      end

      def remove_sub
        @sub.destroy
      end

      def sub_ping
        "#{sub.ping_string}, You've been selected to be a sub for #{region} #{pug_type}. Please report to the #{pug.blue_channel.channel_name}, look for #{event.user.username}."
      end

      attr_accessor :event, :bot
    end
  end
end
