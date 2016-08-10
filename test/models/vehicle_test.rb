# == Schema Information
#
# Table name: vehicles
#
#  id                         :integer          not null, primary key
#  brand_id                   :integer
#  vehicle_model_id           :integer
#  version_id                 :integer
#  customer_id                :integer
#  kilometers                 :integer
#  color                      :string
#  details                    :text
#  cost_in_cents              :integer
#  price_in_cents             :integer
#  entered_on                 :date
#  sold_on                    :date
#  is_consignment             :boolean          default(FALSE)
#  is_financed                :boolean          default(FALSE)
#  minimum_advance_in_cents   :integer
#  transfer_amount_in_cents   :integer
#  plate                      :string
#  year                       :integer
#  motor_number               :string
#  chassis_number             :string
#  created_at                 :datetime
#  updated_at                 :datetime
#  is_owner                   :boolean          default(FALSE)
#  has_automatic_transmission :boolean          default(FALSE)
#  is_hdi                     :boolean          default(FALSE)
#

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase

  def setup
    @vehicle = vehicles(:delorean)
    @owned_vehicle = vehicles(:batmobile)
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

  test "should save owned vehicle without customer" do
    @owned_vehicle.customer = nil
    @owned_vehicle.valid?
    assert_empty @owned_vehicle.errors
  end

end

