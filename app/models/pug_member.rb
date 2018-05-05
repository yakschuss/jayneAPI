class PugMember < ApplicationRecord
  has_many :queue_spots

  def ping_string
    "<@#{discord_id}>"
  end

  def captain_string
    captain? ? "Captain" : ""
  end
end
