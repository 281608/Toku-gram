class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @content = params[:word]
    @method = params[:search]
   if @range == 'User'
      @records = User.search_for(@content, @method)
   else
     @records = Post.search_for(@content, @method)
   end
  end

end
