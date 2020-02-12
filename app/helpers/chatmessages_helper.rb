module ChatmessagesHelper
  def check_sender(chat)
    return "float-right" if chat.user_id == current_user.id
    "float-left"
  end

  def check_recipient(user, params)
    return "show-chat" if user.to_i == params.to_i
    "hide-chat"
  end
end