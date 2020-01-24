# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_likeable, only: %i[index create]

  def index; end

  def create
    return flash.now[:info] = "You can't like more than once" if already_liked?

    redirect_back(fallback_location: root_path)
    @likeable.likes.create(user: current_user)
  end

  def destroy
    @like = Like.find(params[:id])
    return unless @like.user == current_user

    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def already_liked?
    !current_user.likes.find_by(likeable_id: like_params[:likeable_id], likeable_type: like_params[:likeable_type]).nil?
  end

  def set_likeable
    @likeable = like_params[:likeable_type].constantize.find(like_params[:likeable_id])
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
