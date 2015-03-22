class AddSubscriptionAmountToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :subscription_amount, :integer
  end
end
