class Favorite < ApplicationRecord
  belongs_to :profile
  validates :favorite, presence: true
end
