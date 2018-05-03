class Letter < ApplicationRecord
  belongs_to :user

  validates :name, :address, :state, presence: true

  enum state: {to_send: 0, sent: 1, to_trash: 2 }
end
