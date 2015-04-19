class Post < ActiveRecord::Base
  searchkick text_start: [:title]
  acts_as_votable
  belongs_to :user
  has_many :comments
end
