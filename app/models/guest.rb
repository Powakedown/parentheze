class Guest < ApplicationRecord
  validates :email, presence: { message: "ne peut pas être vide" },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "non valide" }
  validates_uniqueness_of :email, conditions: -> { where.not(email: 'email@example.com') }

  scope :parenting, -> { where(parent: 1)}
  scope :with_kid_in_age, -> { where(kid_age: 1)}
  scope :with_jalousy, -> { where( jalous: [1,2])}
  scope :want_to_get_out, -> { where(get_out: [1,2])}
  scope :visitors, -> { where.not(visit: 0)}
  scope :subscriber, -> { where.not(email: "email@example.com")}
end
