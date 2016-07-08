class Review < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validates :body, presence: true
end
