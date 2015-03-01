class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :restaurant_id
      t.integer :category_id
      t.string :item
      t.integer :price

      t.timestamps null: false
    end
  end
end
