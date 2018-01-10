class Plan < ApplicationRecord
  has_many :bookings
  validates :name, presence: true
  validates :price, presence: true
end
