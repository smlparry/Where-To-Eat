class AddInaccuracyToItems < ActiveRecord::Migration
  def change
    add_column :items, :inaccuracy, :boolean
  end
end
