class AddBorderToCaseImage < ActiveRecord::Migration
  def change
    add_column :case_images, :border, :boolean
  end
end
