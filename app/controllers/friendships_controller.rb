class FriendshipsController < ApplicationController
  before_action :create_notification, only: :create

  def create
    if !already_sent?
      current_user.friendships.create(friend_id: @friend_id)
      flash[:success] = "Friend request sent"
    else
      flash[:danger] = "Seems a relationship already exists on both your ends."
    end
    redirect_back(fallback_location: users_path)
  end

  private

  def create_notification
    @notifications = current_user.pending_friends + current_user.friend_requests
    @notifications.compact
  end

  def already_sent?
    @friend_id = friendship_params[:friend_id]
    @friend = User.find(@friend_id)
    @friend.friend_requests.include?(current_user) || @friend.friend?(current_user)
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
