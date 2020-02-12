class ChatmessagesController < ApplicationController
  
  def show
    @params = params[:id]
    @chats = current_user.chats(@params)
    @friends = current_user.friends
    @chat = Chatmessage.new
  end
  
  def create
    recipient = User.find_by(email: chat_params[:recipient])
    @chat = Chatmessage.new(user: current_user, reciever: recipient, message: chat_params[:message])
    if @chat.save
      ChatmessageChannel.broadcast_to Chatmesage chat_params[:message]
      redirect_to chatmessage_path(recipient)
    else
      flash.now[:alert] = "Error"  
    end
  end

  def delete
  end

  private

  def chat_params
    params.require(:chatmessage).permit(:message, :recipient)
  end
end
