class RenameVentasToSales < ActiveRecord::Migration[7.0]
  def change
    rename_table :ventas, :sales
  end
end
