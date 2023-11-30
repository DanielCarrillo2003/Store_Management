class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name 
      t.string :firstname
      t.string :phone_number 
      t.string :enterprise 
      t.timestamps
    end
  end
end
