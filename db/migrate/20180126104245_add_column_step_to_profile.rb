class AddColumnStepToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :step, :integer
  end
end
