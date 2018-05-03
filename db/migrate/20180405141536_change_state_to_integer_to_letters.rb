class ChangeStateToIntegerToLetters < ActiveRecord::Migration[5.1]
  def change
    change_column :letters, :state, 'integer USING CAST(state AS integer)'
  end
end
