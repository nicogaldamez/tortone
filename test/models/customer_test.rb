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
  
  test "should not save customer without phones" do
    delegation = Customer.new(phones: '')
    delegation.valid?
    assert_includes delegation.errors[:phones], 'no puede estar en blanco'
  end
  
  test "should not save customer without email" do
    delegation = Customer.new(email: '')
    delegation.valid?
    assert_includes delegation.errors[:email], 'no puede estar en blanco'
  end

end

