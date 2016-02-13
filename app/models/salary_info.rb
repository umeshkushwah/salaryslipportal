class SalaryInfo < ActiveRecord::Base

  belongs_to :employee
  
  #Validation
  validates :basic, :working_days, :total_working_days, :allowance_added, presence: true, numericality: true
  validates_inclusion_of :working_days, :total_working_days, :in => 1..31
  validates :month, presence: true  
end
