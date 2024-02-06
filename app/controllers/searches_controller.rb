class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'User'
      @records = User.search_for(@content, @method)
    elsif @content == 'Post'
      @records = Post.search_for(@content, @method)
    elsif @model == 'tag'
			@records = Tag.search_posts_for(@content, @method)
	  else
	    @records = []
    end
  end
end
