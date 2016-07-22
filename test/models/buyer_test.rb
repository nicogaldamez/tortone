require 'test_helper'

class BuyerTest < ActiveSupport::TestCase

  test "should not save buyer without first name" do
    buyer = Buyer.new(first_name: '')
    buyer.valid?
    assert_includes buyer.errors[:first_name], 'no puede estar en blanco'
  end

  test "should not save buyer without phone" do
    buyer = Buyer.new(phone: '')
    buyer.valid?
    assert_includes buyer.errors[:phone], 'no puede estar en blanco'
  end

  test "should save min price with 0 when empty" do
    buyer = Buyer.new(min_price: '')
    buyer.valid?
    assert_equal buyer.min_price, 0
  end

  test "should not save buyer without maximum price" do
    buyer = Buyer.new(max_price: '')
    buyer.valid?
    assert_includes buyer.errors[:max_price], 'no puede estar en blanco'
  end

end
