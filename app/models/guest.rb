class Guest < ApplicationRecord
  validates :email, presence: { message: "ne peut pas être vide" },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "non valide" }
end
