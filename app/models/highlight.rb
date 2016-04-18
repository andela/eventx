class Highlight < ActiveRecord::Base
  belongs_to :event

  validates :title, presence: true
  validates :day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :description, presence: true

  mount_base64_uploader :image, PictureUploader
end
