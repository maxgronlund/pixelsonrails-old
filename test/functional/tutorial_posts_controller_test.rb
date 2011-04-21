require 'test_helper'

class TutorialPostsControllerTest < ActionController::TestCase
  setup do
    @tutorial_post = tutorial_posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tutorial_posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tutorial_post" do
    assert_difference('TutorialPost.count') do
      post :create, :tutorial_post => @tutorial_post.attributes
    end

    assert_redirected_to tutorial_post_path(assigns(:tutorial_post))
  end

  test "should show tutorial_post" do
    get :show, :id => @tutorial_post.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tutorial_post.to_param
    assert_response :success
  end

  test "should update tutorial_post" do
    put :update, :id => @tutorial_post.to_param, :tutorial_post => @tutorial_post.attributes
    assert_redirected_to tutorial_post_path(assigns(:tutorial_post))
  end

  test "should destroy tutorial_post" do
    assert_difference('TutorialPost.count', -1) do
      delete :destroy, :id => @tutorial_post.to_param
    end

    assert_redirected_to tutorial_posts_path
  end
end
