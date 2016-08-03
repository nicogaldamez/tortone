# == Schema Information
#
# Table name: vehicle_models
#
#  id         :integer          not null, primary key
#  brand_id   :integer
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class VehicleModelTest < ActiveSupport::TestCase

  def setup
    @vehicle_model = vehicle_models(:focus)
  end

  test "should not save vehicle model without name" do
    @vehicle_model.name = nil
    @vehicle_model.valid?
    assert_includes @vehicle_model.errors[:name], 'no puede estar en blanco'
  end

  test "should not save vehicle model without brand" do
    @vehicle_model.brand = nil
    @vehicle_model.valid?
    assert_includes @vehicle_model.errors[:brand], 'no puede estar en blanco'
  end

  test "should titleize name" do
    @vehicle_model.name = 'focus'
    @vehicle_model.save
    assert_equal 'Focus', @vehicle_model.name
  end

end

