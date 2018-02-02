class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.integer :rating
      t.string :comment
      t.integer :host
      t.references :plan, foreign_key: true
      t.string :date

      t.timestamps
    end
  end
end
