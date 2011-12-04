require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #new" do
      get("/users/new").should route_to("users#new")
    end

    it "routes to #show" do
      get("/users/1").should route_to("users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/users/1/edit").should route_to("users#edit", :id => "1")
    end

    it "routes to #create" do
      #post("/users").should route_to("users#create") # replaced by devise
      post("/users").should route_to("devise/registrations#create")
    end

    it "routes to #update" do
      put("/users/1").should route_to("users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users/1").should route_to("users#destroy", :id => "1")
    end


    # devise routes
    it "route for sign_in" do
      post("users/sign_in").should route_to("devise/sessions#create")
    end

    it "route for sign_out" do
      delete("users/sign_out").should route_to("devise/sessions#destroy")
    end

    it "route for sign_up" do
      get("users/sign_up").should route_to("devise/registrations#new")
    end

    it "route for cancel sign_up" do
      get("users/cancel").should route_to("devise/registrations#cancel")
    end

    it "route for set password" do
      put("users/password").should route_to("devise/passwords#update")
    end

    it "route for new password" do
      get("users/password/new").should route_to("devise/passwords#new")
    end

    it "route for edit password" do
      get("users/password/edit").should route_to("devise/passwords#edit")
    end

    it "route for update password" do
      put("users/password").should route_to("devise/passwords#update")
    end


    # user avatar image crop routes
    it "routes to #crop" do
      get("/users/1/crop").should route_to("users#crop", :id => "1")
    end

    it "routes to #crop_update" do
      put("/users/1/crop_update").should route_to("users#crop_update", :id => "1")
    end
  end
end
