class Admin::PostCommentsController < ApplicationController
  layout 'admin'
  def index
    @post_comments = PostComment.page(params[:page])
    @user = current_user
  end

  def destroy
    PostComment.find_by(id: params[:id]).destroy
    redirect_to request.referer
  end

private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
