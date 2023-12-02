class AddTotalAmountToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :total_amount, :float
  end
end
