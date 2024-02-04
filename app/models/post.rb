class Post < ApplicationRecord
   has_one_attached :image
   belongs_to :user
   validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def self.search_for(content, method)
   if method == 'perfect_match'
      @post = Post.where(title: content)
   elsif method == 'forward_match'
      @post = Post.where('title LIKE ?', content+'%')
   elsif method == 'backward_match'
      @post = Post.where('title LIKE ?', '%'+content)
   elsif method == 'pertial_match'
      @post = Post.where('title LIKE ?', '%'+content+'%')
   else
     @post = Post.all
   end
  end

end
