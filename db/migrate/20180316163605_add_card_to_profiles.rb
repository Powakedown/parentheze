class AddCardToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :card, :integer
  end
end
