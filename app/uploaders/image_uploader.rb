# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::MiniMagick
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience

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
  # process :scale => [200, 300]
  #
  #def scale(width, height)
  #  # do something
  #end

  process :convert => 'jpg'
  process :resize_to_fit => [754, 887]

  # Create different versions of your uploaded files:
  version :thumb do
    #process :scale => [50, 50]
    process :manualcrop
    process :resize_to_fill => [50, 50]
  end
  
  version :small do
    #process :scale => [238, 280]
    process :resize_to_fill => [25, 25]
  end
  
  version :medium do
    #process :scale => [238, 280]
    process :resize_to_fit => [238, 280]
  end
  
  version :large do
    #process :scale => [754, 887]
    process :resize_to_fit => [754, 887]
  end

  #version :original do
  #  process :convert => 'jpg'
  #end

  def manualcrop
    return unless model.cropping?
    manipulate_crop! do |img| 
      #img = img.crop(model.crop_x.to_i,model.crop_y.to_i,model.crop_h.to_i,model.crop_w.to_i) 
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

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
