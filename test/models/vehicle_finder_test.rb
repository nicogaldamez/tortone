require 'test_helper'

class VehicleFinderTest < ActiveSupport::TestCase

  def setup
    @buyer = buyers(:carlos)
  end

  test "should return buyers interested in the vehicle" do
    carlos_interest = buyer_interests(:focus)
    silvia_interest = buyer_interests(:again_focus)

    vehicles = VehicleFinder.new(@buyer).call
    
    assert_equal 1, vehicles.count
  end

end
