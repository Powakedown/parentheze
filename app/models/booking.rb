class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :host
  belongs_to :plan
end
