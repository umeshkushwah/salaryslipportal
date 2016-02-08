class BankDetailController < BaseController
  
  include FindEmployee
  
  layout "admin"

  before_action :find_employee
  before_action :find_bank_detail, except: [:new, :create]
  
  def new
    @bank_detail = @employee.build_bank_detail
  end

  def create
    @bank_detail = @employee.build_bank_detail(bank_details_params)
    if @bank_detail.save
      flash[:notice] = "Bank Details added successfully"
      redirect_to employee_bank_detail_index_path
    else
      flash.now[:error] = @bank_detail.errors.full_messages
      render 'new'
    end
  end

  def update
    if @bank_detail.update(bank_details_params)
      flash[:notice] = "Bank detail updated successfully"
      redirect_to employee_bank_detail_index_path(@employee.id)
    else
      flash.now[:error] = @bank_detail.errors.full_messages
      render :edit
    end
  end

  private

  def bank_details_params
    params.require(:bank_detail).permit(:bank_name, :branch_name, :address, :city, :account_number)
  end

  def find_bank_detail
    @bank_detail = @employee.bank_detail
  end
end