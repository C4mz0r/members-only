class Post < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 50}
  validates :body, presence: true, length: {maximum: 150}
  belongs_to :user
end
