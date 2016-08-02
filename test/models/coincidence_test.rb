# == Schema Information
#
# Table name: coincidences
#
#  id         :integer          not null, primary key
#  buyer_id   :integer
#  vehicle_id :integer
#  is_ignored :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CoincidenceTest < ActiveSupport::TestCase

  def setup
    @coincidence = coincidences(:one)
  end

  test "should not save coincidence without buyer" do
    @coincidence.buyer = nil
    @coincidence.valid?
    assert_includes @coincidence.errors[:buyer], 'no puede estar en blanco'
  end

  test "should not save coincidence without vehicle" do
    @coincidence.vehicle = nil
    @coincidence.valid?
    assert_includes @coincidence.errors[:vehicle], 'no puede estar en blanco'
  end

  test "should set is_ignored to false by default" do
    new_coincidence = Coincidence.new
    assert_equal new_coincidence.is_ignored, false
  end

  test "should not save coincidence if already exists" do
    new_coincidence = Coincidence.new(buyer: @coincidence.buyer, 
                                      vehicle: @coincidence.vehicle)
    
    new_coincidence.valid?
    assert_includes new_coincidence.errors[:buyer], 'ya está en uso'
  end
  
end
