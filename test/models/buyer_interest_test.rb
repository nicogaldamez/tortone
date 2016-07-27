require 'test_helper'

class BuyerInterestTest < ActiveSupport::TestCase

  test "should not save buyer interest without brand" do
    buyer_interest = BuyerInterest.new(brand: nil)
    buyer_interest.valid?
    assert_includes buyer_interest.errors[:brand], 'no puede estar en blanco'
  end

  test "should not save buyer interest without vehicle model" do
    buyer_interest = BuyerInterest.new(vehicle_model: nil)
    buyer_interest.valid?
    assert_includes buyer_interest.errors[:vehicle_model], 'no puede estar en blanco'
  end

  test "should not save buyer interest without year" do
    buyer_interest = BuyerInterest.new(year: '')
    buyer_interest.valid?
    assert_includes buyer_interest.errors[:year], 'no puede estar en blanco'
  end

end
