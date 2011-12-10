class AddTaskToCaseStudy < ActiveRecord::Migration
  def change
    add_column :case_studies, :task, :text
    add_column :case_studies, :year, :string
    add_column :case_studies, :client, :string
    add_column :case_studies, :order, :integer
  end
end
