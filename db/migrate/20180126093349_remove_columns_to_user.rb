class RemoveColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :address, :string
    remove_column :users, :kids, :string
    remove_column :users, :comment, :string
    remove_column :users, :phone, :string
    remove_column :users, :mother_first_name, :string
    remove_column :users, :father_first_name, :string
  end
end
