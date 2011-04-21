require 'test_helper'

class IllustrationsControllerTest < ActionController::TestCase
  setup do
    @illustration = illustrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:illustrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create illustration" do
    assert_difference('Illustration.count') do
      post :create, :illustration => @illustration.attributes
    end

    assert_redirected_to illustration_path(assigns(:illustration))
  end

  test "should show illustration" do
    get :show, :id => @illustration.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @illustration.to_param
    assert_response :success
  end

  test "should update illustration" do
    put :update, :id => @illustration.to_param, :illustration => @illustration.attributes
    assert_redirected_to illustration_path(assigns(:illustration))
  end

  test "should destroy illustration" do
    assert_difference('Illustration.count', -1) do
      delete :destroy, :id => @illustration.to_param
    end

    assert_redirected_to illustrations_path
  end
end
