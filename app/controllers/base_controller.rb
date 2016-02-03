class BaseController < ApplicationController
  
  before_action :authenticate_employee!
  before_action :initialize_organization
  
  def initialize_organization    
    @current_org = current_employee.organization
  end
end
