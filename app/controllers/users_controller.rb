class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]

  def index
    @users = User.all
  end

  def show
    
  end

  def edit

  end

  def update
    if @user.update(update_params)
      flash[:info] = "Profile updated"
      redirect_to path
    else

    end
  end

  def set_user
    @user = User.find(params([:id]))
  end

  def update_params
    params.require(:user).permit(:nickname, :gender, :location, :age)
  end

end