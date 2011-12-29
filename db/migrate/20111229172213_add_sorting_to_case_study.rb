class AddSortingToCaseStudy < ActiveRecord::Migration
  def up
    remove_column :case_studies, :sorting 
    add_column :case_studies, :sorting, :integer
    
    CaseStudy.all.each_with_index do |case_study, index|
      case_study.sorting = index * 100
      case_study.save
    end
  end
  def down
    remove_column :case_studies, :sorting 
    add_column :case_studies, :sorting, :string
    
    
  end
end
