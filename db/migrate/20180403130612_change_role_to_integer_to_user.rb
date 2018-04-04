class ChangeRoleToIntegerToUser < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :role, :integer, default: 0, using: case when false then 0 else 2 end
  end
end
