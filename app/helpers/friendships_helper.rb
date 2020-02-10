# frozen_string_literal: true

module FriendshipsHelper
  def friendship_data(user)
    { friendship: { user_id: current_user.id, friend_id: user.id } }
  end

  def request_data(user)
    { request: { friend: user.id } }
  end

  def relationship?(other_user)
    other_user.rebound_requests.include?(current_user)
  end

  def pending_notif?(other_user)
    other_user.friend_requests.include?(current_user)
  end

  def friends?(other_user)
    other_user.friend?(current_user)
  end

  def has_friends?(user)
    current_user.friends.nil?
  end
end
