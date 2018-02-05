class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :address
      t.integer :kids
      t.string :comment
      t.string :phone
      t.string :mother_first_name
      t.string :father_first_name
      t.integer :rating
      t.integer :step

      t.timestamps
    end
  end
end
