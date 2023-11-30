class AddFieldsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :on_sale, :integer
    add_column :products, :in_stock, :integer
    add_column :products, :lots_in_stock, :integer
    add_column :products, :expiration_date, :date
  end
end
