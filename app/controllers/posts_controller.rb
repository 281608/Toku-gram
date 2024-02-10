class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = @user.id

  # if params[:draft].present?
  #     @post.status = :draft
  # else
  #     @post.status = :published
  # end

   if @post.save
  # if @post.draft?
  #       redirect_to dashboard_posts_path, notice: 'Your draft has been saved.'
  # else
        redirect_to post_path(@post), notice: 'Your post has been published.'
  # end
   else
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

    @post.assign_attributes(post_params)

   if @post.save
      redirect_to redirect_path, notice: notice_message
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
    params.require(:post).permit(:title, :body, :category, :status)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end

end
