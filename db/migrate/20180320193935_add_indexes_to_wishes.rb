class AddIndexesToWishes < ActiveRecord::Migration[5.1]
  def change
    add_index :wishes, :number
  end
end
