class CreateFlashFiles < ActiveRecord::Migration
  def change
    create_table :flash_files do |t|
      t.string :swf
      t.integer :size_x
      t.integer :size_y
      t.string :title
      t.belongs_to :case_study
      t.string :comment

      t.timestamps
    end
    add_index :flash_files, :case_study_id
  end
end
