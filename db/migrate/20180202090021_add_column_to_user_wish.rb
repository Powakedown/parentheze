class AddColumnToUserWish < ActiveRecord::Migration[5.1]
  def change
    add_column :user_wishes, :status, :boolean
  end
end
