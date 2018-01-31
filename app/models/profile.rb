class Profile < ApplicationRecord
  regex = /\A[\w'\-.áéíóúäëïöüÄőŐűŰZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųū][^0-9_! ¡?÷?¿+=@#$%^&*(){}|~<>;:\[\]]{2,}\z/

  validates :mother_first_name, format: { with: Regexp.new(regex), message: 'Le prénom du parent 1 n\'est pas valide' }, :if => :step3?
  validates :father_first_name, format: { with: Regexp.new(regex), message: 'Le prénom du parent 2 n\'est pas valide' }, :if => :step3?, allow_blank: true
  # validates_numericality_of :kids, :greater_than => 0
  validates :kids, presence: true, :if => :step3?, on: :update
  validates :address, presence: true, :if => :step4?, on: :update
  validates :photo, presence: true, :if => :step5?, on: :update

  belongs_to :user

  alias_attribute :first_parent_name, :mother_first_name


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
