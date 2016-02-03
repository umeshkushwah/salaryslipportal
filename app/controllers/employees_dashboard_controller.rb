class EmployeesDashboardController < BaseController
  
 layout "employees"

  def index
    @salary_infos = current_employee.salary_infos.paginate(:page => params[:page], :per_page => 9)
    if @salary_infos.nil?
      flash[:notice] = "Salary info not available"
      redirect_to employees_dashboard_path
    end
  end 
end
