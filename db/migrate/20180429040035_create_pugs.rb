class CreatePugs < ActiveRecord::Migration[5.1]
  def change
    create_table :pugs do |t|
      t.string :pug_type

      t.timestamps
    end
  end
end
