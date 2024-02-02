class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
  end

  def show
  end

  def edit
  end

private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
end
