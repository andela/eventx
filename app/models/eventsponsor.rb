class Eventsponsor < ActiveRecord::Base
  belongs_to :event

  validates :name, presence: true
  validates :logo, presence: true
  validates :level, presence: true

  enum level: { gold: 1, silver: 2, bronze: 3 }

  # fileupload
  mount_uploader :logo, PictureUploader
end
