require 'test_helper'

class InsertMenuControllerTest < ActionController::TestCase
  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get restaurant" do
    get :restaurant
    assert_response :success
  end

  test "should get items" do
    get :items
    assert_response :success
  end

end
