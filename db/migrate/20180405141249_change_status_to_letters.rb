class ChangeStatusToLetters < ActiveRecord::Migration[5.1]
  def change
    change_column :letters, :status, :state
  end
end
