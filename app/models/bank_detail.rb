class BankDetail < ActiveRecord::Base
  belongs_to :employee

  #Validation
  validates :bank_name, :branch_name, :address, :city, presence: true
  validates :account_number, presence: true, uniqueness: true
end
