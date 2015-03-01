class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :restaurant_id
      t.string :category

      t.timestamps null: false
    end
  end
end
