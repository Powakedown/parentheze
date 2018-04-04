# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: { message: 'ne peut pas être vide' },
                    format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :email, uniqueness: { conditions: -> { where.not(email: ['email@example.com', 'parentgenial@parentheze.com']) } }

  delegate :mother_first_name, :father_first_name, :name, :full_name, :address, :kids, :phone, :comment, :names, :card, :validation, :photo, :step, to: :profile, :allow_nil => true

  has_one :profile, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :user_wishes, dependent: :destroy
  has_many :wishes, through: :user_wishes

  enum role: { member: 0, moderator: 1, admin: 2 }
end
