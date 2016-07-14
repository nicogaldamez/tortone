require 'test_helper'

class VehicleModelTest < ActiveSupport::TestCase

  def setup
    @vehicle_model = vehicle_models(:focus)
  end

  test "should not save vehicle model without brand" do
    @vehicle_model.brand = nil
    @vehicle_model.valid?
    assert_includes @vehicle_model.errors[:brand], 'no puede estar en blanco'
  end

end

