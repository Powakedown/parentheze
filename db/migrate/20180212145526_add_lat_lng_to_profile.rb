class AddLatLngToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :lat, :string
    add_column :profiles, :lng, :string
  end
end
