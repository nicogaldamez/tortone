require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  test "should not save customer without first name" do
    delegation = Customer.new(first_name: '')
    delegation.valid?
    assert_includes delegation.errors[:first_name], 'no puede estar en blanco'
  end

  test "should not save customer without last name" do
    delegation = Customer.new(last_name: '')
    delegation.valid?
    assert_includes delegation.errors[:last_name], 'no puede estar en blanco'
  end

end

