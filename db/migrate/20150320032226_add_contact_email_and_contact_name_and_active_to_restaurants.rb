class AddContactEmailAndContactNameAndActiveToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :contact_email, :string
    add_column :restaurants, :contact_name, :string
    add_column :restaurants, :active, :boolean
  end
end
