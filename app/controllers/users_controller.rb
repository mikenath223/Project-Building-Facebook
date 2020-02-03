# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.where('id != ?', current_user.id)
  end

  def show
    @user = User.find(params[:id])
  end
end
