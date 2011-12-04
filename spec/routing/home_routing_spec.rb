require "spec_helper"

describe HomeController do
  describe "routing" do

    it "routes / to home" do
      get("/").should route_to("home#index")
    end

  end
end
