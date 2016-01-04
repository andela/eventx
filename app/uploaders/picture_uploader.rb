
class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Cloudinary::CarrierWave

  version :thumb do
    process eager: true
    process resize_to_fill: [150, 150]
    process quality: 100
  end

  version :landing do
    process eager: true
    process resize_to_fill: [369, 206]
    process quality: 100
  end

  version :main do
    process eager: true
    process resize_to_fill: [1280, 486]
    process quality: 100
  end
end
