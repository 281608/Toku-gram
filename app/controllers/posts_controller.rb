class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(',')
   if @post.save
      @post.save_tags(tag_list)
       flash[:notice] = "You have created post successfully."
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
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def edit
    @post = Post.find(params[:id])
   unless @post.user.id == current_user.id
    redirect_to posts_path
   end
  end

  def update
    @post = Post.find(params[:id])
   if @post.update(post_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to post_path(@post.id)
   else
      render :edit
   end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to '/posts'
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
