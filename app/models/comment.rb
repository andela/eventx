class Comment < ActiveRecord::Base
  belongs_to :event
  belongs_to :review
  belongs_to :user

  validates :body, presence: true
end
