require 'test_helper'

class CasestorriesControllerTest < ActionController::TestCase
  setup do
    @casestorry = casestorries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:casestorries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create casestorry" do
    assert_difference('Casestorry.count') do
      post :create, :casestorry => @casestorry.attributes
    end

    assert_redirected_to casestorry_path(assigns(:casestorry))
  end

  test "should show casestorry" do
    get :show, :id => @casestorry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @casestorry.to_param
    assert_response :success
  end

  test "should update casestorry" do
    put :update, :id => @casestorry.to_param, :casestorry => @casestorry.attributes
    assert_redirected_to casestorry_path(assigns(:casestorry))
  end

  test "should destroy casestorry" do
    assert_difference('Casestorry.count', -1) do
      delete :destroy, :id => @casestorry.to_param
    end

    assert_redirected_to casestorries_path
  end
end
