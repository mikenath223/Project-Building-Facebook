module FriendshipsHelper
  def friendship_data(user)
    { friendship: { user_id: current_user.id, friend_id: user.id } }
  end

  def request_data(user)
    { request: { friend: user.id } }
  end
end
