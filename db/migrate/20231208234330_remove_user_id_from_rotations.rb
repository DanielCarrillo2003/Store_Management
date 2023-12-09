class RemoveUserIdFromRotations < ActiveRecord::Migration[7.0]
  def change
    remove_column :rotations, :user_id, :bigint if column_exists?(:rotations, :user_id)
    remove_index :rotations, name: "index_rotations_on_user_id" if index_exists?(:rotations, :user_id)
  end
end
