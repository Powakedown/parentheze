class Guest < ApplicationRecord
  validates :email, presence: true
end
