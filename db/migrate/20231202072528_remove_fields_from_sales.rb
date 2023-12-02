class RemoveFieldsFromSales < ActiveRecord::Migration[7.0]
  def change
    remove_column :sales, :quantity
    remove_column :sales, :product_id
  end
end
