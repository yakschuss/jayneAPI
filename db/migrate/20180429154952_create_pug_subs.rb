class CreatePugSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :pug_subs do |t|
      t.datetime :expiration_time
      t.string :pug_type
      t.string :region
      t.string :battlenet
      t.string :ping_string

      t.timestamps
    end
  end
end
