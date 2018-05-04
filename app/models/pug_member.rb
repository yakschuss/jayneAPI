class PugMember < ApplicationRecord
  def ping_string
    "<@#{discord_id}>"
  end

  def captain_string
    captain? ? "Captain" : ""
  end
end
