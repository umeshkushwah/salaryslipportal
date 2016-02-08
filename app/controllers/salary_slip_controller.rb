class SalarySlipController < BaseController 

  include FindEmployee

  layout :set_layout
    
  before_action :authenticate_admin, except: [:show_slip]
  before_action :find_employee
  before_action :find_salary_info, only: [:show, :destroy, :show_slip]
  before_action :get_salaries, only: [:index, :destroy]
  
  def new
    @salary_info = @employee.salary_infos.build
  end

  def create
    @salary_info = @employee.salary_infos.build(create_params)
    if @salary_info.save
      flash[:notice] = "Salary Slip generated successfully"
      redirect_to  employee_salary_slip_path(employee_id: @salary_info[:employee_id], id: @salary_info[:id])
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
        format.js{ flash.now[:notice] = "Salary info deleted successfully" }
        format.html
      end
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

  def authenticate_admin    
    unless current_employee.is_admin?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to employees_dashboard_path(current_employee.id)
    end    
  end

  def create_params
    params.require(:salary_info).permit(:basic, :total_working_days, :working_days, :allowance_added, :allowance_deduction, :month)
  end

  def set_layout
    if params[:action] == "show_slip"
      'employees'
    else
      'admin'
    end
  end

  def get_salaries
    @salary_infos = @employee.salary_infos.paginate(:page => params[:page], :per_page => 9)   
  end
end