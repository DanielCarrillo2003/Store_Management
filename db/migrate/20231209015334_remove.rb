class Remove < ActiveRecord::Migration[7.0]
  def change
    remove_column :rotations, :activation_date
  end
end
