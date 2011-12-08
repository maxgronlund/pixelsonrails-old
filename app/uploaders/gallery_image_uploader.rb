# encoding: utf-8

class GalleryImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :convert => 'jpg'
  process :resize_to_limit => [1028, 880]

  # Create different versions of your uploaded files:  
  cattr_accessor :version_dimensions
  self.version_dimensions = {
    :small => [66, 72],
    :medium => [754, 320],
    :large => [1028, 720]
  }

  RESIZE_GRAVITY = 'NorthWest'

  # define versions from dimensions above
  self.version_dimensions.keys.each do |a_version|
    eval <<-EOT
      version :#{a_version} do
        process :manualcrop
        process :resize_to_fill => self.version_dimensions[:#{a_version}] << RESIZE_GRAVITY
      end
EOT
  end

  def manualcrop
    return unless model.cropping?
    return if model.crop_params[version_name.to_sym].blank?
    model.get_crop_version!(version_name)

    manipulate_crop! do |img|
      img.crop("#{model.crop_w.to_i}x#{model.crop_h.to_i}+#{model.crop_x.to_i}+#{model.crop_y.to_i}")
    end
  end

  def manipulate_crop!
    crop_image = ::MiniMagick::Image.open(current_path)
    yield(crop_image)
    crop_image.write(current_path)
  rescue => e
    raise CarrierWave::ProcessingError.new("Failed to manipulate with MiniMagick, maybe it is not an image? Original Error: #{e}")
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
