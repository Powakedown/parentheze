class Guest < ApplicationRecord
  validates :email, presence: { message: "ne peut pas être vide" },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "non valide" }
  validates_uniqueness_of :email, conditions: -> { where.not(email: 'email@example.com') }
end
