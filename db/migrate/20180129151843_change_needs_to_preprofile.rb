class ChangeNeedsToPreprofile < ActiveRecord::Migration[5.1]
  def change
    change_column :preprofiles, :need1, 'integer USING CAST(need1 AS integer)'
    change_column :preprofiles, :need2, 'integer USING CAST(need1 AS integer)'
    change_column :preprofiles, :need3, 'integer USING CAST(need1 AS integer)'
    change_column :preprofiles, :need4, 'integer USING CAST(need1 AS integer)'
  end
end
