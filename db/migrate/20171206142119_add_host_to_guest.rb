class AddHostToGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :guests, :host, :boolean
  end
end
