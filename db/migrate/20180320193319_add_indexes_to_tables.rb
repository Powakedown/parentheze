class AddIndexesToTables < ActiveRecord::Migration[5.1]
  def change
    add_index :profiles, :step
  end
end
