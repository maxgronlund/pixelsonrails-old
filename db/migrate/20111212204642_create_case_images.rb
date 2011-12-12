class CreateCaseImages < ActiveRecord::Migration
  def change
    create_table :case_images do |t|
      t.string :image
      t.text :crop_params
      t.belongs_to :case_study
      t.text :image_text

      t.timestamps
    end
    add_index :case_images, :case_study_id
    
    add_column :case_studies, :image_text, :text
  end
end
