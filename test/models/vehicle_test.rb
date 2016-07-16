require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  
  def setup
    @vehicle = vehicles(:delorean)
  end
  
  test "should not save vehicle without brand" do
    @vehicle.brand = nil    
    @vehicle.valid?
    assert_includes @vehicle.errors[:brand], 'no puede estar en blanco'
  end
  
  test "should not save vehicle without vehicle_model" do
    @vehicle.vehicle_model = nil
    @vehicle.valid?
    assert_includes @vehicle.errors[:vehicle_model], 'no puede estar en blanco'
  end
  
  test "should not save vehicle without customer" do
    @vehicle.customer = nil
    @vehicle.valid?
    assert_includes @vehicle.errors[:customer], 'no puede estar en blanco'
  end
  
  test "should not save vehicle without version" do
    @vehicle.version = nil
    @vehicle.valid?
    assert_includes @vehicle.errors[:version], 'no puede estar en blanco'
  end
  
  test "should not save vehicle without color" do
    @vehicle.color = ''
    @vehicle.valid?
    assert_includes @vehicle.errors[:color], 'no puede estar en blanco'
  end
  
  test "should not save vehicle without year" do
    @vehicle.year = ''
    @vehicle.valid?
    assert_includes @vehicle.errors[:year], 'no puede estar en blanco'
  end
  
  test "should not save vehicle without kilometers" do
    @vehicle.kilometers = ''
    @vehicle.valid?
    assert_includes @vehicle.errors[:kilometers], 'no puede estar en blanco'
  end
  
  test "should save vehicle with valid params" do
    @vehicle.valid?
    assert_empty @vehicle.errors
  end

end

