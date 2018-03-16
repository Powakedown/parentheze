class AddColumnToFavorites < ActiveRecord::Migration[5.1]
  def change
    add_reference :favorites, :user, foreign_key: true
    add_column :favorites, :favorite, :integer
  end
end
