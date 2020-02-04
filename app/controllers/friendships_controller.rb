# frozen_string_literal: true

class FriendshipsController < ApplicationController
  # before_action :create_notification, only: :create

  def create
    if !already_sent?
      current_user.friendships.create(friend_id: @friend_id)
      flash[:success] = 'Friend request sent'
    else
      flash[:danger] = 'Seems a relationship already exists on both your ends.'
    end
    redirect_back(fallback_location: users_path)
  end

  def create_notification
    @notifications = current_user.rebound_requests
  end

  def accept_request
    friend = User.find(request_params[:friend])
    Friendship.create(user_id: current_user.id, friend_id: friend.id)
    if current_user.accept_request(friend)
      redirect_to root_path
      flash[:success] = "Great! You are now friends with #{(friend.nickname || friend.email).capitalize}."
    else
      flash.now[:warning] = 'There was and error completing your request.'
      render 'create_notification'
    end
  end

  def friends
    @friends = current_user.friends
  end

  def delete
    friend_id = request_params[:friend]
    friends = Friendship.find_by(user_id: current_user.id, friend_id: friend_id)
    rebound_friends = Friendship.find_by(user_id: friend_id, friend_id: current_user.id)
    @friendship = friends || rebound_friends
    if @friendship.destroy
      flash[:success] = 'Friend relationship successsfully deleted.'
    else
      flash[:warning] = 'There was an issue unfriending the user.'
    end
    redirect_back(fallback_location: users_path)
  end

  private

  def already_sent?
    @friend_id = friendship_params[:friend_id]
    @friend = User.find(@friend_id)
    current_user.friend_requests.include?(@friend) || @friend.friend?(current_user)
  end

  def request_params
    params.require(:request).permit(:friend)
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
