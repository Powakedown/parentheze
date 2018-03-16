class ChangeColumnCardToProfiles < ActiveRecord::Migration[5.1]
  def change
    change_column :profiles, :card, :integer, default: 0
  end
end
