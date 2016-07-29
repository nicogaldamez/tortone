require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @sale = sales(:delorean_to_carlos)
    @sale_new_data = {vehicle_id: vehicles(:batmobile).id, customer_id: customers(:silvia).id,
                       sold_on: Date.yesterday, price: 2000000, advance: 4000
                      }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Sale.count, assigns(:presenter).send(:sales).send(:count)
  end

  test "should filter sales by from date" do
    get :index, sale_filter: {from: Date.yesterday.strftime('%Y-%m-%d') }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:sales).send(:count)
    assert_includes assigns(:presenter).send(:sales), sales(:delorean_to_carlos).decorate
  end

  test "should filter sales by to date" do
    get :index, sale_filter: {to: Date.yesterday.strftime('%Y-%m-%d') }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:sales).send(:count)
    assert_includes assigns(:presenter).send(:sales), sales(:batmobile_to_silvia).decorate
  end

  test "should filter sales by to vehicle model" do
    get :index, sale_filter: {vehicle_model_id: vehicles(:delorean).vehicle_model_id}
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:sales).send(:count)
    assert_includes assigns(:presenter).send(:sales), sales(:delorean_to_carlos).decorate
  end

  test "should fill form with vehicle data" do
    vehicle = vehicles(:delorean)
    get :new, vehicle_id: vehicle.id
    assert_not_nil assigns(:sale)

    assert_select 'input#sale_vehicle_id' do
      assert_select "[value=?]", vehicle.id.to_s
    end
    assert_select 'input#sale_price' do
      assert_select "[value=?]", vehicle.price.to_s
    end
  end

  test "should create sale" do
    assert_difference('Sale.count', 1) do
      post :create, sale: @sale_new_data
    end
    assert_redirected_to sales_path

    sale = Sale.find_by(sold_on: @sale_new_data[:sold_on])
    sale.as_json.each do |key, value|
      assert_equal @sale_new_data[key.to_sym], value, "No guardó correctamente #{key}" if @sale_new_data.key?(key.to_sym)
    end
  end


end
