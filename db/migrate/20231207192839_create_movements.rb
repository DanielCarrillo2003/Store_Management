class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.string :product_name
      t.integer :quantity_affected
      t.string :movement

      t.timestamps
    end
  end
end
