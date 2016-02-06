class AdminDashboardController < BaseController

  layout "admin"
  
  before_action :find_employee, except: [:index]
  before_action :authenticate_admin
  before_action :get_employees, only: [:index, :destroy]

  def destroy
    if @employee.destroy
      respond_to do |format|
        format.js{ flash.now[:notice] = "Employee was deleted successfully" }
        format.html
      end 
    else
      flash[:error] = @employee.errors.full_messages
      render :index
    end
  end

  def confirm_employee
    @employee.send_confirmation_instructions
    flash[:notice] = "Employee was confirmed successfully"
    redirect_to admin_dashboard_index_path
  end

  private
  
  def find_employee
    @employee =  @current_org.employees.where(id: params[:id]).take
    if @employee.blank?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to admin_dashboard_index_path
    end
  end

  def authenticate_admin    
    unless current_employee.is_admin?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to employees_dashboard_path(current_employee.id)
    end    
  end
  
  def get_employees
    @employees = @current_org.employees.paginate(:page => params[:page], :per_page => 9)
  end
end