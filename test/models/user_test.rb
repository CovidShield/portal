require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @admin = users(:admin)
    @staff = users(:staff)
  end

  test "cannot update the last admin to be staff" do
    assert User.admin.count == 1
    @admin.admin = false
    refute @admin.save
  end

  test "can revert admin to staff if there is another admin" do
    @staff.update(admin: true)
    assert @admin.update(admin: false)
  end
end
