class AddColumnsToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :parent, :boolean
    add_column :guests, :kid_age, :integer
    add_column :guests, :jalous, :integer
    add_column :guests, :old_kid, :integer
    add_column :guests, :name, :string
    add_column :guests, :email, :string
  end
end
