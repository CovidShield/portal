require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the users index" do
    login_as_admin
    visit users_url
    assert_selector "h1", text: "Manage users"
  end

  test "creating a user" do
    login_as_admin
    visit users_url
    click_on "Add user"

    assert_selector "h1", text: "Add user"
    assert_selector "[data-submit=true][disabled]"

    fill_in "Password", with: 'secret'
    fill_in "Confirm password", with: 'secret'
    fill_in "Username", with: 'jill'
    click_on "Add user"

    assert_selector "h1", text: "Manage users"
  end

  test "updating a user" do
    login_as_admin
    visit users_url
    click_on "Edit", match: :first

    assert_selector "h1", text: "Edit user"
    assert_selector "[data-submit=true][disabled]"

    fill_in "Password", with: 'secret'
    fill_in "Confirm password", with: 'secret'
    fill_in "Username", with: 'steve'
    click_on "Save changes"

    assert_selector "h1", text: "Manage users"
  end

  test "deleting a user" do
    login_as_admin
    visit users_url
    click_on "Remove", match: :first
    click_on "Remove user", match: :first

    assert_selector "h1", text: "Manage users"
  end
end
