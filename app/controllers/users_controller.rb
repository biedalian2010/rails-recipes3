class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timezone
  before_action :find_user



  def edit
    # 跟刚才后台情况一样,如果没有  @user.profile, 要先新建一个
    # unless @user.profile 等同于 if !@user.profile 或 if @user.profile.nil?
    @user.create_profile unless @user.profile
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "修改成功"
      redirect_to edit_user_path
    else
      render "edit"
    end
  end

    def show
    end

  def set_timezone
    if current_user && current_user.time_zone
      Time.zone = current_user.time_zone
    end
  end

  protected

  def find_user
    @user = current_user
    @user.create_profile unless @user.profile
  end

  def user_params
    params.require(:user).permit(:time_zone, :profile_attributes => [:id, :legal_name, :birthday, :location, :education, :occupation, :bio, :specialty] )
  end

end
