class PugMember < ApplicationRecord
  has_many :queue_spots

  def ping_string
    "<@#{discord_id}>"
  end

  def captain_string
    captain? ? "Captain" : ""
  end

  def info
    "#{discord_tag} --- #{battlenet}, #{region}, #{peak_sr}"
  end
end
