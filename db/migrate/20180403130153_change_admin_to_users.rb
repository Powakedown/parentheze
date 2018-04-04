class ChangeAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :admin, :role
  end
end
