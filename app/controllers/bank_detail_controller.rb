class BankDetailController < BaseController
  
  include FindEmployee
  
  layout "admin"

  before_action :find_employee, only: [:create, :new, :index, :edit, :update, :show]
  before_action :find_bank_detail, only: [:index, :edit, :update, :show]
  
  def new
    @bank_detail = BankDetail.new
  end

  def create
    @bank_detail = @employee.build_bank_detail(create_params)
    if @bank_detail.save
      flash[:notice] = "Bank Details added successfully"
      redirect_to employee_bank_detail_index_path
    else
      flash.now[:error] = @bank_detail.errors.full_messages
      render 'new'
    end
  end

  def update
    if @bank_detail.update(update_params)
      flash[:notice] = "Bank detail updated successfully"
      redirect_to employee_bank_detail_index_path(@employee.id)
    else
      flash.now[:error] = @bank_detail.errors.full_messages
      render :edit
    end
  end

  private

  def create_params
    params.require(:@bank_detail).permit(:bank_name, :branch_name, :address, :city, :account_number)
  end

  def update_params
    params.require(:bank_detail).permit(:bank_name, :branch_name, :address, :city, :account_number)
  end

  def find_bank_detail
    @bank_detail = @employee.bank_detail
  end
end