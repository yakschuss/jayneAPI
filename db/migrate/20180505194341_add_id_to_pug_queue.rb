class AddIdToPugQueue < ActiveRecord::Migration[5.1]
  def change
    add_column :queue_spots, :pug_id, :integer
  end
end
