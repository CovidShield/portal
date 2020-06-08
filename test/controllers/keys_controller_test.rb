require 'test_helper'
require 'webmock/minitest'

class KeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:staff)
  end

  test "when not logged in you are redirected login screen" do
    post keys_generate_url format: 'json'
    assert_redirected_to login_url
  end

  test "post for keys when logged in" do
    request_url = "https://" + ENV['KEY_CLAIM_HOST'] + "/new-key-claim";
    stub_request(:post, request_url).
      to_return(body: "12345678")

    sign_in_as(@user)
    post keys_generate_url format: 'json'
    assert_response :success, {key: "12345678"}
  end

  test "server status code is forwarded to response" do
    request_url = "https://" + ENV['KEY_CLAIM_HOST'] + "/new-key-claim";
    stub_request(:post, request_url).
      to_return(status: 403)

    sign_in_as(@user)
    post keys_generate_url format: 'json'
    assert_response 403
  end
end
