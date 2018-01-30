class AddColumnToPreprofile < ActiveRecord::Migration[5.1]
  def change
    add_column :preprofiles, :need1, :boolean
    add_column :preprofiles, :need2, :boolean
    add_column :preprofiles, :need3, :boolean
    add_column :preprofiles, :need4, :boolean
  end
end
