require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 600]

  def login_as_admin
    @user = users(:admin)
    visit login_url
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: 'secret'
    click_on "Sign in"
  end

  def login_as_staff
    @user = users(:staff)
    visit login_url
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: 'secret'
    click_on "Sign in"
  end
end
