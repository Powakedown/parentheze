class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  validates :host, presence: true
  validates :date, presence: true
end
