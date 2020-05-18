require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:staff)
  end

  test "when not logged in you get login screen" do
    get home_index_url
    assert_redirected_to login_url
  end

  test "when logged in as staff you get index" do
    sign_in_as(@user)
    get home_index_url
    assert_response :success
  end
end
