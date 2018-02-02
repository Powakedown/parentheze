class AddColumnRatingToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :rating, :integer
  end
end
