class ChatmessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat"

    # or
    # stream_from "room_#{params[:room]}"
  end
end