class AddHasItemsToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :has_items, :boolean
  end
end
