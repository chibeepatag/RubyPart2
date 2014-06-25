require 'test_helper'

class SupplierControllerTest < ActionController::TestCase
  test "should get orderID" do
    get :orderID
    assert_response :success
  end

  test "should get customerContact" do
    get :customerContact
    assert_response :success
  end

end
