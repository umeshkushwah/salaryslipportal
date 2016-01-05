class Employee < ActiveRecord::Base

  #Associations
  has_one :role
  belongs_to :organization
  has_many :salary_infos
  
  #Validations
  validates :first_name, presence: true, length: {minimum: 3}
  validates :last_name, presence: true, length: {minimum: 3}

  #Devise
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #Methods
  def is_admin?
    if !self.role.nil?
      if self.role.name =="admin"
        return true
      else
        return false
      end   
    end       
  end

  def get_full_name
    if !self.nil?
      first_name.to_s() + " " + last_name.to_s()
    end
  end

end
