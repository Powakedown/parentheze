class AddAddressToLetter < ActiveRecord::Migration[5.1]
  def change
    add_column :letters, :address, :string
  end
end
