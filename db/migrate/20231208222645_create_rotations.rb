class CreateRotations < ActiveRecord::Migration[7.0]
  def change
    create_table :rotations do |t|
      t.string :username
      t.datetime :scheduled_at
      t.datetime :activation_date
      t.datetime :completed_at
      t.boolean :completed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
