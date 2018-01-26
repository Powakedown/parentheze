class Profile < ApplicationRecord
  validates :mother_first_name, presence: true
  validates_numericality_of :kids, :greater_than => 0
  validates :address, presence: true
  validates :phone, presence: true

  belongs_to :user
end
