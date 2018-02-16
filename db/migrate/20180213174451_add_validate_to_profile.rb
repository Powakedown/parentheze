class AddValidateToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :validate, :integer
  end
end
