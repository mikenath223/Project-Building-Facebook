module ChatmessagesHelper
  def check_sender(chat)
    return "float-right" if chat.user_id == current_user.id
    "float-left"
  end
end
