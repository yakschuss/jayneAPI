class Pug < ApplicationRecord
  PUG_TYPES = %w(
  highsr
  mixedsr
  )

  REGIONS = %w(
   EU
   NA
   OCE
   PTR)

  has_many :pug_members, dependent: :destroy
  has_many :channel_records, dependent: :destroy


  validates :pug_type, inclusion: { in: PUG_TYPES }
  validates :region, inclusion: { in: REGIONS }

  def full?
    pug_members.count == 12
  end

  def self.unfilled
      joins(:pug_members).
        select("pugs.*").
        group("pugs.id").
        having("count(pug_members.id) < 12")
  end

  def blue_channel
    channel_records.where("channel_records.channel_name LIKE ?", "%-Blue").first
  end

  def needs_captain?
    pug_members.where(captain: true).count < 2
  end

  def captains
    pug_members.where(captain: true).pluck(:ping_string).first(2)
  end

  def captain_names
    pug_members.where(captain: true).pluck(:discord_tag).first(2)
  end

  def member_count
    "#{pug_members.count}/12"
  end

  def meta_data
    "ID:#{id} - #{region} #{pug_type} - #{member_count} members"
  end

  def pug_ping
    """
You are being pinged to play in a #{pug_type} PUG. Please report to #{blue_channel.channel_name}.\n

#{captain_string}

#{captains.first} please create an invite only custom game with the competitive preset and begin inviting players once they confirm they are in-game. If someone does not confirm they are here in the next two minutes, go to #pug-general and type ?sub-request to replace them.

#{member_info}
    """
  end

  def member_info
    pug_members.map do |member|
      member.pug_ping
    end.join("\n")
  end

  def captain_string
    if needs_captain? 
      "This pug is still in need of captains. Please designate a captain to fill this role."
    else
      "Your captains are #{captains.join(" and ")}"
    end
  end
end
