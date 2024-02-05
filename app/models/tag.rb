class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  scope :merge_post, -> (tags){ }

  def self.search_posts_for(content, method)

    if method == 'perfect'
      tags = Tag.where(name: content)
    elsif method == 'forward_match'
      tags = Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward_match'
      tags = Tag.where('name LIKE ?', '%' + content)
    else
      tags = Tag.where('name LIKE ?', '%' + content + '%')
    end

    return tags.inject(init = []) {|result, tag| result + tag.posts}

  end
end
