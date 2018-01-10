class Wish < ApplicationRecord
  has_many :user_wishes
  validates :name, presence: true
end
