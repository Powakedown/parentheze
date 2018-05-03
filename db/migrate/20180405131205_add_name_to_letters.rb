class AddNameToLetters < ActiveRecord::Migration[5.1]
  def change
    add_column :letters, :name, :string
  end
end
