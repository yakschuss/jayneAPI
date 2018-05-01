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

        if id.nil?
          return "Ya'll need to give me an ID so I can get you a sub."
        end

        if sub && pug
          channel = bot.pm_channel(sub.discord_id)
          bot.send_message(channel, sub_ping)
          battlenet = sub.battlenet
          remove_sub

          "<@#{event.user.id}>, The battlenet for the sub is #{battlenet}."
        else
          "Either there are no subs registered, or there's no PUG with the ID you gave me."
        end
      end

      private

      def id
        arguments[0]
      end

      def pug
        @pug ||= Pug.find_by(id: id)
      end

      def sub
        @sub ||= PugSub.where("pug_subs.expiration_time > ?", Time.current).
          where(region: pug.region, pug_type: pug.pug_type).order(created_at: :asc).first
      end

      def remove_old_subs
        PugSub.where("pug_subs.expiration_time < ?", Time.current).delete_all
      end

      def remove_sub
        @sub.destroy
      end

      def sub_ping
        "#{sub.ping_string}, You've been selected to be a sub for #{pug.region} #{pug.pug_type}. Please report to the #{pug.blue_channel.channel_name}, look for #{event.user.username}."
      end

      attr_accessor :event, :bot
    end
  end
end
