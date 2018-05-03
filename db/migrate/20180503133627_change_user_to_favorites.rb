class ChangeUserToFavorites < ActiveRecord::Migration[5.1]
  def change
    remove_column :favorites, :user_id
    add_reference :favorites, :profile, foreign_key: true
  end
end
