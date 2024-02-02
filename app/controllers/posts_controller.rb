class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
   if @post.save
       flash[:notice] = "You have created book successfully."
    redirect_to post_path(@post.id)
   else
     @posts = Post.all
     @user = current_user
     render :index
   end
  end

  def index
    @posts = Post.all
    @user = current_user
  end

  def show
  end

  def edit
  end

private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end

end
