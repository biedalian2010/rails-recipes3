class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timezone



  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "修改成功"
      redirect_to edit_user_path
    else
      render "edit"
    end
  end

  def set_timezone
    if current_user && current_user.time_zone
      Time.zone = current_user.time_zone
    end
  end

  protected

  def user_params
    params.require(:user).permit(:time_zone)
  end

end
