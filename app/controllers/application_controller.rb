class ApplicationController < ActionController::Base  
  protect_from_forgery
  skip_before_action :verify_authenticity_token

  def after_sign_in_path_for(resource)
    if resource.is_admin?
      admin_dashboard_index_path
    else
      employees_dashboard_index_path
    end
  end
end
