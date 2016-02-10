class BaseController < ApplicationController
  
  before_action :authenticate_employee!
  before_action :current_org
  
  def current_org
    @current_org = current_employee.organization
  end
end
