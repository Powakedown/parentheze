class AddConfidenceToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :confidence, :boolean
  end
end
