class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :host, foreign_key: true
      t.references :plan, foreign_key: true
      t.string :date

      t.timestamps
    end
  end
end
