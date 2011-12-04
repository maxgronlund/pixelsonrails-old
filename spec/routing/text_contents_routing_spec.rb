require "spec_helper"

describe TextContentsController do
  describe "routing" do

    it "routes to #index" do
      get("/text_contents").should route_to("text_contents#index")
    end

    it "routes to #new" do
      get("/text_contents/new").should route_to("text_contents#new")
    end

    it "routes to #show" do
      get("/text_contents/1").should route_to("text_contents#show", :id => "1")
    end

    it "routes to #edit" do
      get("/text_contents/1/edit").should route_to("text_contents#edit", :id => "1")
    end

    it "routes to #create" do
      post("/text_contents").should route_to("text_contents#create")
    end

    it "routes to #update" do
      put("/text_contents/1").should route_to("text_contents#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/text_contents/1").should route_to("text_contents#destroy", :id => "1")
    end

  end
end
