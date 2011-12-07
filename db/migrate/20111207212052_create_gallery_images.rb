class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.string :title
      t.text :body
      t.string :image
      t.text :crop_params

      t.timestamps
    end
  end
end
