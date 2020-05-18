require 'application_system_test_case'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)

class UsersTest < ApplicationSystemTestCase
  test "code generation and reset works" do
    request_url = "https://" + ENV['KEY_CLAIM_HOST'] + "/new-key-claim";
    stub_request(:post, request_url).
      to_return(body: "12345678")

    login_as_admin
    visit root_url
    assert_selector "h2", text: "Ensure patient has installed the COVID Shield app"
    assert_selector "h2", text: "Provide patient with COVID Shield code"
    assert_selector "[data-reset-code][disabled]"
    click_on "Generate code"

    assert_selector "[data-code-result]", text: '1234 5678'
    assert_selector "[data-reset-code]:not([disabled])"

    click_on "Next patient"
    assert_no_selector "[data-code-result]"
  end

  test "menu popover works for admins" do
    login_as_admin
    visit root_url
    click_on "Menu"

    assert_selector "a", text: "Manage users"
    assert_selector "a", text: "Settings"
    assert_selector "a", text: "Sign out"
  end

  test "menu popover works for staff" do
    login_as_staff
    visit root_url
    click_on "Menu"

    assert_selector "a", text: "Manage users", count: 0
    assert_selector "a", text: "Settings"
    assert_selector "a", text: "Sign out"
  end

  test "help modal works" do
    login_as_staff
    visit root_url
    find("[data-modal-activator=step2-2]").click

    assert_selector "#step2-2[data-modal-active]"

    page.driver.browser.action.key_down(:escape).perform
    assert_selector "#step2-2[data-modal-active]", count: 0
  end  
end
