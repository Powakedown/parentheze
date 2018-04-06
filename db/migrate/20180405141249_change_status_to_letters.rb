class ChangeStatusToLetters < ActiveRecord::Migration[5.1]
  def change
    rename_column :letters, :status, :state
  end
end
