class Employees::RegistrationsController < Devise::RegistrationsController
  before_action :find_organization, only: [:create]
  before_action :initialize_organization, only: [:edit, :update]
  layout :set_layout
  
  def create
    build_resource(sign_up_params.merge(organization_id: @organization.id))
    resource.skip_confirmation_notification!
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.create_role(name: "Employee")
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end  
  end
  
  protected

  def find_organization
    @organization = Organization.where("domain = ?", request.domain).take
    if @organization.blank?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to new_employee_registration_path 
    end
  end

  def sign_up_params
    params.require(:employee).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:employee).permit(:email, :first_name, :last_name, :password, :password_confirmation, :current_password, :address, :pin_code, :city, :mobile, :dob, :gender, :degignation, :date_of_joining)
  end

  def set_layout
    if ['edit', 'update'].include? params[:action]
      if current_employee.is_admin?
        'admin'
      else
        'employees'
      end
    else
      'application'
    end
  end

  def initialize_organization    
    @current_org = current_employee.organization
  end
end
