class CreateLot < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.references :product, null: false, foreign_key: true
      t.date :expiration_date
      t.timestamps
    end
  end
end
