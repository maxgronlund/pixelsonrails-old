class FlashFile < ActiveRecord::Base

  mount_uploader :swf, SwfUploader
end
