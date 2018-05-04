class QueueSpot < ApplicationRecord
  class << self
    def gm_game(region)
      where(region: region).where("queue_spots.peak_sr >= '3900'").first_come_first_serve.limit(12)
    end

    def diamond_plus_game(region)
      where(region: region).where("queue_spots.peak_sr >= '2900'").first_come_first_serve.limit(12)
    end

    def mixed_sr_game(region)
      where(region: region).first_come_first_serve.limit(12)
    end

    def first_come_first_serve
      order(created_at: :asc)
    end
  end
end
