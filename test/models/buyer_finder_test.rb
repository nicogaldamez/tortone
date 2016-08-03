require 'test_helper'

class BuyerFinderTest < ActiveSupport::TestCase

  def setup
    @vehicle = vehicles(:delorean)
    @carlos_interest = buyer_interests(:focus)
    @silvia_interest = buyer_interests(:again_focus)
  end

  test "should only return buyers interested in the vehicle" do
    buyers = BuyerFinder.new(@vehicle).call
    
    assert_equal 1, buyers.count
  end

end
