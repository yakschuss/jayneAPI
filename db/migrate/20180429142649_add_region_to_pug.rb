class AddRegionToPug < ActiveRecord::Migration[5.1]
  def change
    add_column :pugs, :region, :string
  end
end
