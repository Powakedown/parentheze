class AddStatusToLetter < ActiveRecord::Migration[5.1]
  def change
    add_column :letters, :status, :string
  end
end
