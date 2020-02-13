class ChatmessagesController < ApplicationController
  
  def show
    @params = params[:id]
    @chats = current_user.chats(@params)
    @friends = current_user.friends
    @chat = Chatmessage.new
  end
  
  def message_request
    @params = params[:id]
    @chats = current_user.chats(@params)
    @chat = Chatmessage.new
    render 'show'
  end

  def create
    recipient = User.find_by(email: chat_params[:recipient])
    @chat = Chatmessage.new(user: current_user, reciever: recipient, message: chat_params[:message])
    if @chat.save
      # ActionCable.server.broadcast 'room_channel',
      #                               content: @chat.message,
      #                               time: @chat.created_at
      redirect_to chatmessage_path(recipient)
    else
      flash.now[:alert] = "Error"
      render 'show'
    end
  end

  def delete
  end

  private

  def chat_params
    params.require(:chatmessage).permit(:message, :recipient)
  end
end
