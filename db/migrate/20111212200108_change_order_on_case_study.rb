class ChangeOrderOnCaseStudy < ActiveRecord::Migration
  def up
    remove_column :case_studies, :order
    add_column :case_studies, :sorting, :string
    
    CaseStudy.all.each do |case_study|
      case_study.sorting = '0'
      case_study.save
    end
      
      
  end

  def down
    remove_column :case_studies, :sorting
    add_column :case_studies, :order, :integer
    
    CaseStudy.all.each do |case_study|
      case_study.order = 0
      case_study.save
    end
  end
end
