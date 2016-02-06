class OrganizationsController < BaseController

  include SetLayout

  layout :set_layout

  def update
    if @current_org.update(update_params)
      flash[:notice] = "Organization record updated successfully"
      redirect_to admin_dashboard_index_path
    else
      flash[:error] = @current_org.errors.full_messages
      redirect_to edit_organization_path
    end
  end
  
  private
  
  def update_params
    params.require(:organization).permit(:name, :address, :domain, :city, :state, :pin_code, :phone, :logo)
  end
end