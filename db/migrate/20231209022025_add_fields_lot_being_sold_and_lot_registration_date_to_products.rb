class AddFieldsLotBeingSoldAndLotRegistrationDateToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :lot_on_sale_number, :integer
    add_column :products, :lot_on_sale_registration_date, :date
  end
end
