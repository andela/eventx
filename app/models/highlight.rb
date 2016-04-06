class Highlight < ActiveRecord::Base
  belongs_to :event

  # fileupload
  mount_uploader :image, PictureUploader
end
