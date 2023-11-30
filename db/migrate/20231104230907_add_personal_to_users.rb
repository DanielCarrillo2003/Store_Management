class AddPersonalToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :personal, :boolean, :default => false
    add_column :users, :username, :string
  end
end
