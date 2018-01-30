class AddStepToPreprofile < ActiveRecord::Migration[5.1]
  def change
    add_column :preprofiles, :step, :integer
  end
end
