require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.new(
        id: SecureRandom.uuid,
        name: 'Manager',
        active: true
    )
  end

  test "should be valid" do
    assert @customer.valid?
  end

  test "name should be present" do
    @customer.name = "     "
    assert_not @customer.valid?
  end

  test "name should not be too long" do
    @customer.name = "a" * 101
    assert_not @customer.valid?
  end
end
