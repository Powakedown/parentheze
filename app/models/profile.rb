class Profile < ApplicationRecord
  validates :mother_first_name, presence: true, :if => :step3?
  # validates_numericality_of :kids, :greater_than => 0
  validates :kids, presence: true, :if => :step3?
  validates :address, presence: true, :if => :step4?
  validates :photo, presence: true, :if => :step5?

  belongs_to :user

  def step3?
    step == 3
  end

  def step4?
    step == 4
  end

  def step5?
    step == 5
  end
end
