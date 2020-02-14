# frozen_string_literal: true

module ChatmessagesHelper
  def check_sender(chat)
    return 'float-right' if chat.user_id == current_user.id

    'float-left'
  end

  def check_recipient(user, params)
    return 'show-chat' if user.to_i == params.to_i

    'hide-chat'
  end

  def check_avatar(chat)
    return current_user if chat.user_id == current_user.id

    User.find(chat.reciever_id)
  end

  def get_current_chatter(var)
    user = User.find(var)
    return user.email if user.nickname.blank?
    user.nickname
  end
end
