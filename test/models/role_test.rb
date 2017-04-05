require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  def setup
    @role = Role.new(
        id: SecureRandom.uuid,
        name: 'Manager',
        symbol: 3
    )
  end

  test "should be valid" do
    assert @role.valid?
  end

  test "name should be present" do
    @role.name = "     "
    assert_not @role.valid?
  end

  test "symbol should be present" do
    @role.symbol = "     "
    assert_not @role.valid?
  end

  test "name should not be too long" do
    @role.name = "a" * 51
    assert_not @role.valid?
  end
end
