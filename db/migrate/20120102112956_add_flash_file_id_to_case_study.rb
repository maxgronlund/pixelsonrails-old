class AddFlashFileIdToCaseStudy < ActiveRecord::Migration
  def change
    add_column :case_studies, :flashfile_id, :integer
  end
end
