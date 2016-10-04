class Review < ActiveRecord::Base
  belongs_to :response, polymorphic: true
  has_many :reviews, as: :response
  belongs_to :event
  belongs_to :user
  validates :body, presence: true
end
