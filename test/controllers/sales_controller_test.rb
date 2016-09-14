require 'test_helper'

class SalesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @sale = sales(:mater_to_silvia)
    @sale_new_data = {vehicle_id: vehicles(:batmobile).id, customer_id: customers(:carlos).id,
                       sold_on: Date.yesterday, price: 2000000, advance: 4000,
                       advance_delivered_on: Date.today, cash: 100000
                      }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Sale.has_finished.count, assigns(:presenter).send(:sales).send(:count)
  end

  test "should filter sales by from date" do
    get :index, sale_filter: {from: Date.yesterday.strftime('%Y-%m-%d') }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:sales).send(:count)
    assert_includes assigns(:presenter).send(:sales), sales(:mater_to_silvia).decorate
  end

  test "should filter sales by to date" do
    get :index, sale_filter: {to: Date.yesterday.strftime('%Y-%m-%d') }
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:sales).send(:count)
    assert_includes assigns(:presenter).send(:sales), sales(:meteoro_to_silvia).decorate
  end

  test "should filter sales by to vehicle model" do
    get :index, sale_filter: {hide_not_finished: "0", vehicle_model_id: vehicles(:lightning_mcqueen).vehicle_model_id}
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:sales).send(:count)
    assert_includes assigns(:presenter).send(:sales), sales(:lightning_mcqueen_to_carlos).decorate
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

  test 'should show sale' do
    get :show, id: @sale.id
    assert_response :success
  end

  test "should create sale" do
    assert_difference('Sale.count', 1) do
      post :create, sale: @sale_new_data
    end

    sale = Sale.find_by(sold_on: @sale_new_data[:sold_on])
    assert_redirected_to sale_path(sale)
    sale.as_json.each do |key, value|
      assert_equal @sale_new_data[key.to_sym], value, "No guardó correctamente #{key}" if @sale_new_data.key?(key.to_sym)
    end
  end

  test "should get edit sale" do
    get :edit, id: @sale
    assert_equal @sale, assigns(:sale)
  end

  test "should update sale" do
    assert_record_differences(@sale, @sale_new_data) do
      put :update, id: @sale.id, sale: @sale_new_data
    end
    assert_redirected_to sale_path(@sale)
  end

  test "should destroy sale" do
    assert_difference('Sale.count', -1) do
      delete :destroy, id: @sale.id
    end

    assert_redirected_to sales_path
  end

  test 'should display form to print advance certificate' do
    get :pre_print_advance_certificate, id: @sale
    assert_equal @sale, assigns(:sale)
  end

  test 'should print advance certificate' do
    post :pre_print_advance_certificate, id: @sale
    assert_equal @sale, assigns(:sale)
  end

end
