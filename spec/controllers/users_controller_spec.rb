require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "user not logged in" do

    it "should not GET index" do
      get :index
      response.should redirect_to(no_access_index_path)  # FIXME is this correct?
    end

    it "should not GET show" do
      get :show, :id => @user.id
      response.should_not be_success
    end

    # TODO new/create ok

    # TODO edit/update/delete not ok

  end

  describe "user logged in" do

    before (:each) do
      sign_in @user
    end



    it "should GET index" do
      get :index
      #response.should redirect_to(root_path)
      # FIXME gives a 200; is that what we expect?
    end



    describe "GET 'show'" do

      it "should be successful" do
        get :show, :id => @user.id
        response.should be_success
      end

      it "should find the right user" do
        get :show, :id => @user.id
        assigns(:user).should == @user
      end

    end


  end

end
