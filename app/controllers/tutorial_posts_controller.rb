class TutorialPostsController < InheritedResources::Base
  
  belongs_to :tutorial , :optional => true

  
  

   
   
  def create
    create! {tutorial_path(@tutorial_post.tutorial)}
  end
  
  def update
    update! {tutorial_path(@tutorial_post.tutorial)}
  end
  
end
