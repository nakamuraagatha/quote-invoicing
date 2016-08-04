class ItemUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :fog

  version :thumb do
    process resize_to_fill: [90,90]
  end

  version :medium do
    process resize_to_fill: [300, 300]
  end


  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def content_type_whitelist
    /image\//
  end

  def extension_white_list
    %w(jpg jpeg png gif bmp)
  end

end