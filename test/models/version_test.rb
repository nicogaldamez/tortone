require 'test_helper'

class VersionTest < ActiveSupport::TestCase

  def setup
    @version = versions(:trend)
  end

  test "should not save version without vehicle model" do
    @version.vehicle_model = nil
    @version.valid?
    assert_includes @version.errors[:vehicle_model], 'no puede estar en blanco'
  end

end

