class AddFieldsToLots < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :amount, :integer
  end
end
