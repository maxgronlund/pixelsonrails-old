class TutorialPostsController < InheritedResources::Base
  
  belongs_to :tutorial , :optional => true
  
end
