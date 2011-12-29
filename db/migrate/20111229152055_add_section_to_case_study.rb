class AddSectionToCaseStudy < ActiveRecord::Migration
  def change
    add_column :case_studies, :section, :string
    
    CaseStudy.all.each do |case_study|
      case_study.section = 'portfolio'
      case_study.save
    end
  end
end
