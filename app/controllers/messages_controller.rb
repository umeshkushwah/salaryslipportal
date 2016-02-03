class MessagesController < BaseController

  include SetLayout

  layout :set_layout

  def create
    recipients = Employee.where(id: params['recipients'])
    conversation = current_employee.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation    
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end
end
