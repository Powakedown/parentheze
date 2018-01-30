class Preprofile < ApplicationRecord
  belongs_to :user
  validates :mother_first_name, presence: true, :if => Proc.new { |pp| pp.step == 2 }

  has_attachment :photo

end
