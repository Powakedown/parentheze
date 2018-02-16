class Profile < ApplicationRecord
  regex_name = /\A[^0-9][\w'\-áéíóúäëïöüÄőŐűŰZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÉÈÊĒÀÄ][^0-9_!.¡?÷?¿+=@#$%^&*(){}|~<>;:\[\]]{0,}\z/
  regex_phone = /(0|\\+33|0033)[1-9][0-9]{8}/

  validates :mother_first_name, format: { with: Regexp.new(regex_name), message: 'Le prénom du parent 1 n\'est pas valide' }, :if => :step3?
  validates :father_first_name, format: { with: Regexp.new(regex_name), message: 'Le prénom du parent 2 n\'est pas valide' }, :if => :step3?, allow_blank: true
  validates_numericality_of :kids, :greater_than => 0, message: 'Vous devez être parent et avoir au moins 1 enfant', :if => :step3?
  validates :kids, presence: { message: 'Vous devez être parent et avoir au moins 1 enfant' }, :if => :step3?
  validates :phone, format: { with: Regexp.new(regex_phone), message: 'Le numéro de téléphone n\'pas valide'}, :if => :step4?, allow_blank: true
  validates :address, presence: true, :if => :step4?
  validates :photo, presence: true, :if => :step6?

  belongs_to :user

  alias_attribute :parent1, :mother_first_name
  alias_attribute :parent2, :father_first_name

  has_attachment :photo

  def step3?
    step == 3
  end

  def step4?
    step == 4
  end

  def step5?
    step == 5
  end

  def step6?
    step == 6
  end
end