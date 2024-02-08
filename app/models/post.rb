class Post < ApplicationRecord
  enum status: { published: 0, draft: 1,  unpublished: 2 }
   has_one_attached :image
   belongs_to :user
   has_many :tags, through: :post_tags
   has_many :goods, dependent: :destroy
   has_many :post_comments, dependent: :destroy

   validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :category, presence: true

  def gooded_by?(user)
    goods.where(user_id: user.id).exists?
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
