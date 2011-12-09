class Ability
  include CanCan::Ability

  def initialize(user)
    if user 
      if user.super?
        can :manage, :all
      elsif user.admin?
        can :manage, User
        can :manage, TextContent
        can :manage, GalleryImages
        can :manage, CaseStudy
        
        # add application-specific changes below
        
        
      elsif user.member?
        # Ordinary user
        can :manage, User, :id => user.id # <--- Allow user to manage self
        can :read, TextContent
        can :read, GalleryImage
        can :read, CaseStudy
        
        # add application-specific changes below
        
        
      end
    else
      # When not logged in
      can :create, User # <----------- Uncomment this to alow users to signup by them self
      can :read, TextContent
      can :read, GalleryImages
      can :read, CaseStudy
      # add application-specific changes below
      
      
    end
  end
end
