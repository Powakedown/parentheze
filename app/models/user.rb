# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: { message: 'ne peut pas être vide' },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :email, uniqueness: { conditions: -> { where.not(email: ['email@example.com', 'parentgenial@parentheze.com']) } }

  delegate :mother_first_name, :father_first_name, :address, :kids, :phone, :comment, :step, to: :profile, :allow_nil => true

  has_one :profile, dependent: :destroy
  has_many :bookings
  has_many :user_wishes, dependent: :destroy
  has_many :wishes, through: :user_wishes

  def self.admin?
    admin == true
  end
end
