class SalaryInfo < ActiveRecord::Base

  belongs_to :employee
  
  #Validation
  validates :basic, :working_days, :total_working_days, :allowance_added, :allowance_deduction, presence: true, numericality: true
  validates_inclusion_of :working_days, :total_working_days, :in => 1..31
  validates :month, presence: true
  validate :validate_working_days
  after_create :update_salary_slip_info

  private

  def update_salary_slip_info
    service_obj = SalarySlipService.new(self)
    @salary_info = service_obj.update_salary_info
   end

   def validate_working_days
    if working_days > total_working_days
      errors.add(:working_days, 'can not be greater than total working days' )
    end
  end  
end
