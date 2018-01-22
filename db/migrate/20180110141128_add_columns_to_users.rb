class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mother_first_name, :string
    add_column :users, :father_first_name, :string
    add_column :users, :address, :string
    add_column :users, :kids, :integer
    add_column :users, :comment, :string
    add_column :users, :phone, :string
  end
end
