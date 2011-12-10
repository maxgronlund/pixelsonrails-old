class AddOrderToGalleryImage < ActiveRecord::Migration
  def up

    add_column :gallery_images, :sorting, :integer
    
    GalleryImage.all.each do |image|
      image.sorting = 0
      image.save
    end
  end
  
  def down
    remove_column :gallery_images, :sorting
  end
end
