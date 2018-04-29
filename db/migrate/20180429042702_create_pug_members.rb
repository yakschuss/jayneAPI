class CreatePugMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :pug_members do |t|
      t.integer :pug_id
      t.string :ping_string
      t.string :discord_tag
      t.string :battlenet
      t.boolean :captain

      t.timestamps
    end
  end
end
