class RenameValidateToProfile < ActiveRecord::Migration[5.1]
  def change
    rename_column :profiles, :validate, :validation
  end
end
