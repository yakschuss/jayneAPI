class CreateChannelRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :channel_records do |t|
      t.integer :pug_id
      t.string :channel_uuid
      t.string :channel_name

      t.timestamps
    end
  end
end
