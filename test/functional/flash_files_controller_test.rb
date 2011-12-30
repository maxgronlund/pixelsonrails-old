require 'test_helper'

class FlashFilesControllerTest < ActionController::TestCase
  setup do
    @flash_file = flash_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flash_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flash_file" do
    assert_difference('FlashFile.count') do
      post :create, flash_file: @flash_file.attributes
    end

    assert_redirected_to flash_file_path(assigns(:flash_file))
  end

  test "should show flash_file" do
    get :show, id: @flash_file.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flash_file.to_param
    assert_response :success
  end

  test "should update flash_file" do
    put :update, id: @flash_file.to_param, flash_file: @flash_file.attributes
    assert_redirected_to flash_file_path(assigns(:flash_file))
  end

  test "should destroy flash_file" do
    assert_difference('FlashFile.count', -1) do
      delete :destroy, id: @flash_file.to_param
    end

    assert_redirected_to flash_files_path
  end
end
