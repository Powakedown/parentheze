class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates :email, presence: { message: "ne peut pas être vide" }, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "non valide" }


end
