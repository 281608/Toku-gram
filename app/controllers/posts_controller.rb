class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    category_list = params[:post][:category_name].split(',')
   if params[:draft].present?
      @post.status = :draft
   else
      @post.status = :published
   end
   if @post.save
    if @post.draft?
        redirect_to posts_path, notice: 'Your draft has been saved.'
    else
        redirect_to post_path(@post.id), notice: 'Your post has been published.'
    end
     @post.save_categories(category_list)
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
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
   unless @post.user.id == current_user.id
    redirect_to posts_path
   end
  end

  def update
    @post = Post.find(params[:id])
    if params[:draft].present?
      @post.status = :draft
      notice_message = "I saved the draft."
      redirect_path = posts_path
    else params[:unpublished].present?
      @post.status = :unpublished
      notice_message = "I made it private."
      redirect_path = posts_path
    end
    if @post.save
      redirect_to redirect_path, notice: notice_message
    end
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
    params.require(:post).permit(:title, :body, :category, :status)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end

end
