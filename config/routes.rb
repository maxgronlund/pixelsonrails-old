Rails_template::Application.routes.draw do






  resources :gibbon_campaigns, :only => :index

  resources :gibbon_lists, :only => :index do
    resources :gibbon_lists_members, :as => :members
  end

  scope "/:locale" do
    resources :casestorries,:comments, :blogs,:home,:illustrations,:pages, :users, :tutorials,:tutorial_posts
  end

  
  devise_for :users
 
  
  get "about/index"
  get "contact/index"


  scope "/:locale" do
    resources :users do
      resources :blogs
      resources :blogs do
        resources :comments
      end
      resources :comments
    end
  end 
  
  resources :blogs do
    resources :comments
  end
  
  resources :tutorials do
    resource :tutorial_posts
  end
  
  
  
  resource :locale
  
  
  root :to => "home#index"
  
  scope "/:locale" do
    
    match "admin" => 'admin#index'
    match "about" => 'about#index'
  end
  match "search" => 'search#index'
  
  
  


end
