class AddRegionAndCaptainToQueueSpot < ActiveRecord::Migration[5.1]
  def change
    add_column :queue_spots, :captain, :boolean
    add_column :queue_spots, :region, :string
  end
end
