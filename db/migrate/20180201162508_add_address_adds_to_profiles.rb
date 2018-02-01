class AddAddressAddsToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :zip_code, :string
    add_column :profiles, :city, :string
  end
end
