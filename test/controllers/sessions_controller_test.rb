require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:staff)
  end

  test "login page should render" do
    get login_url
    assert_response :success
  end

  test "should set user_id in session and redirect to root on login" do
    post sessions_url(username: @user.username, password: 'secret')
    assert_redirected_to root_url
    assert session[:user_id] == @user.id
  end

  test "should clear session and redirect on logout" do
    sign_in_as(@user)
    get logout_url
    assert_redirected_to login_url
    assert session[:user_id] == nil
  end
end
