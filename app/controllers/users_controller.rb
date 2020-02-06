# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.where('id != ?', current_user.id).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end
end
