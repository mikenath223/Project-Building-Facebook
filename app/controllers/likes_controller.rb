# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_likeables, only: %i[index create]

  def index; end

  def create
    if already_liked?
      flash[:info] = "You can't like more than once"
    else
      @likeable.likes.create(user: current_user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    return unless @like.user == current_user

    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def already_liked?
    !current_user.likes.find_by(likeables_id: like_params[:likeables_id], likeables_type: like_params[:likeables_type]).nil?
  end

  def set_likeables
    @likeable = like_params[:likeables_type].constantize.find(like_params[:likeables_id])
  end

  def like_params
    params.require(:like).permit(:likeables_id, :likeables_type)
  end
end
