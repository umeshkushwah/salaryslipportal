class SalarySlipService 
  
  include Rails.application.routes.url_helpers

  def initialize(params, employee)
    @params = params
    @basic = get_basic_payable
    @employee = employee
  end

  def create_salary_info
    salary_info = @employee.salary_infos.new(set_params)
    return salary_info.save, salary_info   
  end

  def update_salary_info
    salary_info = @employee.salary_infos.where(id: @params[:id]).take
    return salary_info.update(set_params), salary_info
  end

  private

  def set_params
    { basic: @params[:basic],
    allowance_added: @params[:allowance_added],
    allowance_deduction: @params[:allowance_deduction],
    total_working_days: @params[:total_working_days],
    working_days: @params[:working_days],
    month: @params[:month],  
    hra: get_hra,
    provident_fund: get_pf, 
    proffesional_tax: get_proffesional_tax,
    gross_earning: get_gross_earning,
    gross_deduction: get_gross_deduction,
    net_pay: get_net_pay }
  end

  def get_basic_payable
    ((@params[:basic].to_f / @params[:total_working_days].to_i) * @params[:working_days].to_i)
  end

  def get_hra
    (@basic * 40) / 100
  end

  def get_pf
    (@basic * 12) / 100
  end

  def get_proffesional_tax
    (@basic * 1.75) / 100
  end

  def get_gross_earning
    @basic + get_hra + @params[:allowance_added].to_f
  end

  def get_gross_deduction
    get_pf + get_proffesional_tax + @params[:allowance_deduction].to_f
  end

  def get_net_pay
    get_gross_earning - get_gross_deduction
  end
end