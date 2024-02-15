class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = @user.id

   if @post.save
     flash[:notice] = "You have created post successfully."
     redirect_to post_path(@post.id), notice: 'Your post has been published.'

   else
     @posts = Post.all
      render :index
   end

  end

  def index
    @posts = Post.page(params[:page]).where(status:0)
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
   unless @post.user.id == current_user.id
    redirect_to posts_path
   end
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "You have updated post successfully."
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
    params.require(:post).permit(:title, :body, :category, :status, :image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end

end
