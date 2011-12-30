require 'test_helper'

class KobloStudioControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
