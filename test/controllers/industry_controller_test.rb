require 'test_helper'

class IndustryControllerTest < ActionController::TestCase
  test "should get tree" do
    get :tree
    assert_response :success
  end

end
