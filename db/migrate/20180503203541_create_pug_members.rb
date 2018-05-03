class CreatePugMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :pug_members do |t|
      t.string :discord_id
      t.string :discord_tag
      t.string :battlenet
      t.boolean :captain
      t.string :peak_sr
      t.string :region

      t.timestamps
    end
  end
end
