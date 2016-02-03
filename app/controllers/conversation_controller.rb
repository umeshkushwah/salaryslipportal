class ConversationController < BaseController

  include SetLayout

  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash]

  layout :set_layout

  def index
    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
  end

  def reply
    current_employee.reply_to_conversation(@conversation, params[:body])
    respond_to do |format|
      format.js{ flash.now[:success] = "Message sent" }
      format.html
    end
  end

  def destroy
    @conversation.move_to_trash(current_employee)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversation_index_path
  end

  def mark_as_read
    @conversation.mark_as_read(current_employee)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversation_index_path
  end

  private

  def get_mailbox
    @mailbox = current_employee.mailbox
  end

  def get_conversation
    @conversation = @mailbox.conversations.where(id: params[:id]).take
    if @conversation.nil?
      flash[:notice] = "You don't have access to the requested url"
      redirect_to admin_dashboard_index_path
    end
  end
end
