class CreateUserWishes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_wishes do |t|
      t.references :user, foreign_key: true
      t.references :wish, foreign_key: true

      t.timestamps
    end
  end
end
