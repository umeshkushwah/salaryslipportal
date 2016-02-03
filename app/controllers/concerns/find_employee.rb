module FindEmployee

  extend ActiveSupport::Concern

  def find_employee
    @employee =  @current_org.employees.where(id: params[:employee_id]).take
    if @employee.blank?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to admin_dashboard_index_path
    end
  end
end