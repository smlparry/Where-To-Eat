require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get rank" do
    get :rank
    assert_response :success
  end

end
