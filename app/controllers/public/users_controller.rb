class Public::UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    if current_user.id == @user.id
      @posts = current_user.posts
    else
      @posts = @user.posts.where(status:0)
    end
  end

  def edit
    @user = User.find(params[:id])
   unless @user == current_user
    redirect_to user_path(current_user.id)
   end
  end

  def update
    @user = User.find(params[:id])
   unless @user.id == current_user.id
    redirect_to posts_path
   end
   if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
   else
      render :edit
   end
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
