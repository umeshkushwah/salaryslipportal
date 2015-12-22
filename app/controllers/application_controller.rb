class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protect_from_forgery
  skip_before_action :verify_authenticity_token

  def after_sign_in_path_for(resource)
    home_index_path
  end

 # def configure_permitted_parameters
 #    devise_parameter_sanitizer.for(:account_update) { |u| 
 #      u.permit(:password, :password_confirmation, :current_password) 
 #    }
 #  end
  # def after_sign_out_path_for(resource)
  #   root_path
  # end


end
