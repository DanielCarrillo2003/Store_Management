class CreateVentas < ActiveRecord::Migration[7.0]
  def change
    create_table :ventas do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :date_time
      t.integer :quantity
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
