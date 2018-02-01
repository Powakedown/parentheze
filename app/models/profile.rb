class Profile < ApplicationRecord
  regex = /\A[^0-9][\w'\-áéíóúäëïöüÄőŐűŰZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųū][^0-9_!.¡?÷?¿+=@#$%^&*(){}|~<>;:\[\]]{1,}\z/

  validates :mother_first_name, format: { with: Regexp.new(regex), message: 'Le prénom du parent 1 n\'est pas valide' }, :if => :step3?
  validates :father_first_name, format: { with: Regexp.new(regex), message: 'Le prénom du parent 2 n\'est pas valide' }, :if => :step3?, allow_blank: true
  validates_numericality_of :kids, :greater_than => 0, message: 'Vous devez être parent et avoir au moins 1 enfant'
  validates :kids, presence: { message: 'Vous devez être parent et avoir au moins 1 enfant' }, :if => :step3?
  validates :address, presence: true, :if => :step4?
  validates :photo, presence: true, :if => :step5?

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
