class CreateLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :letters do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
