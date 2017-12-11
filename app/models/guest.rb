# frozen_string_literal: true

class Guest < ApplicationRecord
  validates :email, presence: { message: 'ne peut pas être vide' },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: 'non valide' }
  validates :email, uniqueness: { conditions: -> { where.not(email: ['email@example.com', 'parentgenial@parentheze.com']) } }

  scope :parenting, -> { where(parent: 1) }
  scope :with_kid_in_age, -> { where(kid_age: 1) }
  scope :with_jalousy, -> { where(jalous: [1,2]) }
  scope :want_to_get_out, -> { where(get_out: [1,2]) }
  scope :visitors, -> { where.not(visit: 0) }
  scope :subscriber, -> { where.not(email: 'email@example.com') }
  scope :not_tester, -> { where.not(email: 'parentgenial@parentheze.com') }
  scope :target1, -> { where(parent:1, jalous:1, get_out:2) }
  scope :target2, -> { where(parent:1, jalous:2, get_out:1) }

  def kid?
    parent == 1
  end

  def be_jalous?
    jalous == 1 || jalous == 2
  end

  def with_kid_in_age?
    kid_age == 1
  end

  def want_get_out?
    get_out == 1 || get_out == 2
  end
end
