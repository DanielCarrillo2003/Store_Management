class AddCellNumberRfcToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :rfc, :string
  end
end