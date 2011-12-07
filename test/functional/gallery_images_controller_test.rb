require 'test_helper'

class GalleryImagesControllerTest < ActionController::TestCase
  setup do
    @gallery_image = gallery_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gallery_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery_image" do
    assert_difference('GalleryImage.count') do
      post :create, gallery_image: @gallery_image.attributes
    end

    assert_redirected_to gallery_image_path(assigns(:gallery_image))
  end

  test "should show gallery_image" do
    get :show, id: @gallery_image.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery_image.to_param
    assert_response :success
  end

  test "should update gallery_image" do
    put :update, id: @gallery_image.to_param, gallery_image: @gallery_image.attributes
    assert_redirected_to gallery_image_path(assigns(:gallery_image))
  end

  test "should destroy gallery_image" do
    assert_difference('GalleryImage.count', -1) do
      delete :destroy, id: @gallery_image.to_param
    end

    assert_redirected_to gallery_images_path
  end
end
