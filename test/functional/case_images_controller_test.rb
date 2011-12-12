require 'test_helper'

class CaseImagesControllerTest < ActionController::TestCase
  setup do
    @case_image = case_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:case_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case_image" do
    assert_difference('CaseImage.count') do
      post :create, case_image: @case_image.attributes
    end

    assert_redirected_to case_image_path(assigns(:case_image))
  end

  test "should show case_image" do
    get :show, id: @case_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case_image.to_param
    assert_response :success
  end

  test "should update case_image" do
    put :update, id: @case_image.to_param, case_image: @case_image.attributes
    assert_redirected_to case_image_path(assigns(:case_image))
  end

  test "should destroy case_image" do
    assert_difference('CaseImage.count', -1) do
      delete :destroy, id: @case_image.to_param
    end

    assert_redirected_to case_images_path
  end
end
