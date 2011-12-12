class CaseImagesController < InheritedResources::Base
  
  load_and_authorize_resource
  
  belongs_to :case_study, :optional => true
  
  def create
    create! {case_study_path(@case_image.case_study)}
  end
  
  def update
    update! {case_study_path(@case_image.case_study)}
  end
  
  def destroy
    go_to = @case_image.case_study
    destroy! {go_to}
  end

end
