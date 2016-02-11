class BankDetail < ActiveRecord::Base
  belongs_to :employee

  #Validation
  validates :bank_name, :branch_name, :address, :city, presence: true, length: {minimum: 3}
  validates :account_number, presence: true, uniqueness: true, length: {minimum: 6}
end
