class CreatePreprofiles < ActiveRecord::Migration[5.1]
  def change
    create_table :preprofiles do |t|
      t.string :address
      t.integer :kids
      t.string :mother_first_name
      t.string :father_first_name
      t.references :user, foreign_key: true
      t.string :phone

      t.timestamps
    end
  end
end
