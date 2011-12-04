require 'test_helper'
#require File.expand_path('../../../spec/factories', __FILE__)

class TextContentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @text_content = text_contents(:one)

    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:text_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create text_content" do
    assert_difference('TextContent.count') do
      post :create, text_content: @text_content.attributes
    end

    #assert_redirected_to text_content_path(assigns(:text_content))
    assert_redirected_to text_contents_path
  end

  test "should show text_content" do
    get :show, id: @text_content.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @text_content.to_param
    assert_response :success
  end

  test "should update text_content" do
    put :update, id: @text_content.to_param, text_content: @text_content.attributes
    #assert_redirected_to text_content_path(assigns(:text_content))
    assert_redirected_to text_contents_path
  end

  test "should destroy text_content" do
    assert_difference('TextContent.count', -1) do
      delete :destroy, id: @text_content.to_param
    end

    assert_redirected_to text_contents_path
  end
end
