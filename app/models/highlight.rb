class Highlight < ActiveRecord::Base
  belongs_to :event

  # fileupload
  mount_base64_uploader :image, PictureUploader
end
