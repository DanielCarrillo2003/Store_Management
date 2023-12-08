class AddFieldsToMovements < ActiveRecord::Migration[7.0]
  def change
    add_column :movements, :day, :string
    add_column :movements, :month, :string
    add_column :movements, :year, :string
  end
end
