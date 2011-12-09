class CreateCaseStudies < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|
      t.string :title
      t.text :body
      t.string :image
      t.text :crop_params

      t.timestamps
    end
  end
end
