class Post < ActiveRecord::Base
  searchkick text_start: [:title]
  acts_as_votable
  belongs_to :user
  has_many :comments

  def self.search(query)
    if query.present?
      Post.order('created_at DESC').search(query, operator: 'or', text_start: [:title])
    else
      Post.all.order('created_at DESC')
    end
  end
end
