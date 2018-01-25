class AddColumnToWishes < ActiveRecord::Migration[5.1]
  def change
    add_column :wishes, :number, :integer
  end
end
