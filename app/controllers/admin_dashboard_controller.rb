class AdminDashboardController < BaseController
  layout "admin"
  before_filter :find_employee, except: [:index]
  before_filter :authenticate_admin

  def index
    @employees = @current_org.employees
  end

  def destroy
    if @employee.destroy 
      flash[:notice] = "Employee was deleted successfully"
      redirect_to admin_dashboard_index_path
    else
      employee.errors.full_messages.join("/n")
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
      redirect_to home_index_path
    end    
  end
end
