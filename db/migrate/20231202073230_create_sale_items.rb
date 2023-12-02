class CreateSaleItems < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
