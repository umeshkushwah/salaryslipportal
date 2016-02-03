class SalarySlipService 
  
  include Rails.application.routes.url_helpers

  def initialize(params)
    @params = params
  end

  def update_salary_info
    @salary_info = SalaryInfo.where(id: @params[:id]).update_all(hra: get_hra, provident_fund: get_pf, proffesional_tax: get_proffesional_tax, gross_earning: get_gross_earning, gross_deduction: get_gross_deduction, net_pay: get_net_pay)   
  end

  private

  def get_basic_payable
    ((@params[:basic] / @params[:total_working_days]) * @params[:working_days])
  end

  def get_hra
    (get_basic_payable * 40) / 100
  end

  def get_pf
    (get_basic_payable * 12) / 100
  end

  def get_proffesional_tax
    (get_basic_payable * 1.75) / 100
  end

  def get_gross_earning
    get_basic_payable + get_hra + @params[:allowance_added]
  end

  def get_gross_deduction
    get_pf + get_proffesional_tax + @params[:allowance_deduction]
  end

  def get_net_pay
    get_gross_earning - get_gross_deduction
  end
end