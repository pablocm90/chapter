class CoverPicUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
