class MessagesController < ApplicationController
  layout 'admin'
  before_action :find_message, only: [:show, :destroy]
  def index
    @messages = Message.all.order('created_at ASC')
  end

  def show
    @message.update_attributes(read: true)
  end

  def destroy
    if @message.destroy
      redirect_to :back
    else
      render 'index'
    end
  end

  private
  def message_params
    params.require(:message).permit(:id)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end
