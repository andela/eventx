class Sponsor < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
  validates :level, presence: true
  validates :url, presence: true
  validates :summary, presence: true

  enum level: { gold: 1, silver: 2, bronze: 3 }

  # fileupload
  mount_uploader :logo, PictureUploader
end
