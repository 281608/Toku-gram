class Post < ApplicationRecord
   has_one_attached :image
   belongs_to :user
   has_many :tags, through: :post_tags
   has_many :goods, dependent: :destroy

   validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :tag, presence: true

  def gooded_by?(user)
    goods.where(user_id: user.id).exists?
  end

  def save_tags(savebook_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今postが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - savebook_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = savebook_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << post_tag
    end
  end

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
