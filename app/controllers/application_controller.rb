class ApplicationController < ActionController::Base  

  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_admin?
      admin_dashboard_index_path
    else
      employees_dashboard_path(current_employee.id)
    end
  end

  def authenticate_admin    
    unless current_employee.is_admin?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to employees_dashboard_path(current_employee.id)
    end    
  end
end
