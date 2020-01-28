module FriendshipsHelper
  def friendship_data(u)
    { friendship: { user_id: current_user.id, friend_id: u.id } }
  end
end
