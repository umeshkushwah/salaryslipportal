class Employee < ActiveRecord::Base

  acts_as_messageable

  #Associations
  has_one :role
  belongs_to :organization
  has_many :salary_infos
  has_one :bank_detail
  
  #Validations
  validates :first_name, :last_name, presence: true, length: {minimum: 3}, format: {with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/ }

  #Devise
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #Methods
  def is_admin?  
    role.name == "admin"   
  end
  
  def full_name
    first_name.to_s + " " + last_name.to_s
  end

  def mailboxer_email(object)
    self.email
  end
end