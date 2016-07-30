require 'test_helper'

class VehiclesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @vehicle = vehicles(:delorean)
    @vehicle_new_data = {  brand_id: brands(:volkswagen).id,
                           customer_id: customers(:silvia).id,
                           vehicle_model_id: vehicle_models(:bora).id,
                           version_id: versions(:cc).id,
                           color: 'red',
                           kilometers: 1000,
                           entered_on: Date.today,
                           year: 2014,
                           is_hdi: true,
                           has_automatic_transmission: true,
                           plate: 'NEW123'
                          }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Vehicle.not_sold.count, assigns(:presenter).send(:vehicles).send(:count)
  end


  test "should filter vehicles by brand" do
    get :index, vehicle_filter: {brand: @vehicle.brand.name}
    assert_response :success

    assert_equal 2, assigns(:presenter).send(:vehicles).send(:count)
    assert_includes assigns(:presenter).send(:vehicles), @vehicle.decorate
  end

  test "should filter vehicles by vehicle_model" do
    get :index, vehicle_filter: {vehicle_model: @vehicle.vehicle_model.name}
    assert_response :success

    assert_equal 2, assigns(:presenter).send(:vehicles).send(:count)
    assert_includes assigns(:presenter).send(:vehicles), @vehicle.decorate
  end

  test "should get new vehicle" do
    get :new
    assert_not_nil assigns(:vehicle)
  end

  test "should show vehicle" do
    get :show, id: @vehicle.id
    assert_not_nil assigns(:vehicle)
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count', 1) do
      post :create, vehicle: @vehicle_new_data
    end
    new_vehicle = Vehicle.find_by(plate: @vehicle_new_data[:plate])

    assert_redirected_to new_vehicle

    new_vehicle.as_json.each do |key, value|
      assert_equal @vehicle_new_data[key.to_sym], value if @vehicle_new_data.key?(key.to_sym)
    end
  end

  test "should get edit vehicle" do
    get :edit, id: @vehicle
    assert_equal @vehicle, assigns(:vehicle)
  end

  test "should update vehicle" do
    assert_record_differences(@vehicle, @vehicle_new_data) do
      put :update, id: @vehicle.id, vehicle: @vehicle_new_data
    end
    assert_redirected_to vehicles_path
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete :destroy, id: @vehicle.id
    end

    assert_redirected_to vehicles_path
  end

end
