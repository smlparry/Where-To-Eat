class AddUriToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :uri, :string
  end
end
