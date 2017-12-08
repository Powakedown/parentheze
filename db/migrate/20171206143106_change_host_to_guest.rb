class ChangeHostToGuest < ActiveRecord::Migration[5.1]
  def change
    change_column :guests, :host, 'integer USING CAST(host AS integer)'
  end
end
