class PugSub < ApplicationRecord
  def discord_id
    ping_string.tr("<>", "")[1..-1]
  end
end
