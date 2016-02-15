class SalarySlipController < BaseController 

  include FindEmployee
  include DateTimeHelper
  layout :set_layout
    
  before_action :authenticate_admin, except: [:show_slip]
  before_action :find_employee
  before_action :find_salary_info, except: [:new, :create, :index]
  before_action :get_salaries, only: [:index, :destroy]
  
  def new
    @salary_info = @employee.salary_infos.new
  end

  def create
    @salary_info = @employee.salary_infos.new(salary_params)
    if @salary_info.valid?
      salary_info = SalarySlipService.new(salary_params, @employee)
      result, salary_info = salary_info.create_salary_info
      if result
        flash[:notice] = "Salary Slip was generated successfully"
        redirect_to  employee_salary_slip_path(@employee.id, salary_info.id)
      else
        flash.now[:error] = salary_info.errors.full_messages
        render 'new'      
      end  
    else
      flash.now[:error] = @salary_info.errors.full_messages
      render 'new'      
    end
  end
  
  def show_slip
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SalarySlipPdf.new(@salary_info, @employee, @current_org)
        send_data pdf.render, filename: "Salary_Slip.pdf",
        type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def destroy
    if @salary_info.destroy
      respond_to do |format|
        format.js{ flash.now[:notice] = "Salary info was deleted successfully" }
        format.html
      end
    else
      flash[:notice] = "You don't have access to the requested url"
      redirect_to employee_salary_slip_index_path(@employee.id)
    end
  end
  
  def update
    salary_info = SalarySlipService.new(salary_params.merge(id: @salary_info.id), @employee)
    result, salary_info = salary_info.update_salary_info
    if result
      flash[:notice] = "Salary slip was update successfully"
      redirect_to  employee_salary_slip_path(@employee.id, @salary_info.id)
    else
      flash.now[:error] = salary_info.errors.full_messages
      render 'edit'      
    end  
  end
  
  private
  
  def find_salary_info
    @salary_info = @employee.salary_infos.where(id: params[:id]).take
    if @salary_info.blank?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to employee_salary_slip_index_path
    end
  end

  def salary_params
    params.require(:salary_info).permit(:basic, :allowance_added, :allowance_deduction, :month).merge(total_working_days: params[:total_working_days], working_days: params[:working_days])
  end

  def set_layout
    if params[:action] == "show_slip"
      'employees'
    else
      'admin'
    end
  end

  def get_salaries
    @salary_infos = @employee.salary_infos.order(:month).paginate(:page => params[:page], :per_page => 9)   
  end
end