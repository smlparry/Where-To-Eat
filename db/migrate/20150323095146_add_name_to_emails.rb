class AddNameToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :name, :string
  end
end
