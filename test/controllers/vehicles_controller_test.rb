require 'test_helper'
require 'pp'

class VehiclesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @vehicle = vehicles(:delorean)
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Vehicle.count, assigns(:presenter).send(:vehicles).send(:count)
  end


  test "should filter vehicles by brand" do
    get :index, vehicle_filter: {brand: @vehicle.brand.name}
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:vehicles).send(:count)
    assert_includes assigns(:presenter).send(:vehicles), @vehicle.decorate
  end

  test "should filter vehicles by vehicle_model" do
    get :index, vehicle_filter: {vehicle_model: @vehicle.vehicle_model.name}
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:vehicles).send(:count)
    assert_includes assigns(:presenter).send(:vehicles), @vehicle.decorate
  end

  test "should get new vehicle" do
    get :new
    assert_not_nil assigns(:vehicle)
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count', 1) do
      post :create, vehicle: { brand_id: brands(:ford).id,
                               customer_id: customers(:carlos).id,
                               vehicle_model_id: vehicle_models(:focus).id,
                               version_id: versions(:kinetic).id,
                               color: 'red',
                               kilometers: 1000,
                               entered_on: '2016-01-01',
                               year: '2010'
                              }
    end

    assert_redirected_to vehicles_path
  end

  test "should get edit vehicle" do
    get :edit, id: @vehicle
    assert_equal @vehicle, assigns(:vehicle)
  end

  test "should update vehicle" do
    new_brand_id         = brands(:ford).id
    new_vehicle_model_id = vehicle_models(:focus).id
    new_kilometers       = 2000

    put :update, id: @vehicle.id, vehicle: {
                                     brand_id: new_brand_id,
                                     vehicle_model_id: new_vehicle_model_id,
                                     kilometers: new_kilometers
                            }

    assert_redirected_to vehicles_path

    @vehicle.reload
    assert_equal new_brand_id, @vehicle.brand_id
    assert_equal new_vehicle_model_id, @vehicle.vehicle_model_id
    assert_equal new_kilometers, @vehicle.kilometers
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete :destroy, id: @vehicle.id
    end

    assert_redirected_to vehicles_path
  end

end
