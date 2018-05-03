class CreateQueueSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_spots do |t|
      t.string :discord_id
      t.string :peak_sr

      t.timestamps
    end
  end
end
