require 'test_helper'
require 'pp'
class CustomersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @customer = customers(:carlos)
    @customer_new_data = {first_name: 'Nuevo', last_name: 'Cliente', email: 'nuevo@cliente.com',
                               phones: '3123123213/123123123', dni: '30876960',
                               address: '48 1488', description: 'Este es el nuevo cliente'
                              }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Customer.count, assigns(:presenter).send(:customers).send(:count)
  end


  test "should filter customers by first name" do
    get :index, customer_filter: {name: @customer.first_name}
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:customers).send(:count)
    assert_includes assigns(:presenter).send(:customers), @customer.decorate
  end

  test "should filter customers by last name" do
    get :index, customer_filter: {name: @customer.last_name}
    assert_response :success

    assert_equal 1, assigns(:presenter).send(:customers).send(:count)
    assert_includes assigns(:presenter).send(:customers), @customer.decorate
  end

  test "should get new customer" do
    get :new
    assert_not_nil assigns(:customer)
    assert_template layout: 'layouts/application'
    assert_select 'form[action=?]' , '/customers'

    get :new, modal: true
    assert_template layout: nil
    assert_select 'form[action=?]', '/customers.json'
  end

  test "should create customer" do
    assert_difference('Customer.count', 1) do
      post :create, customer: @customer_new_data
    end
    assert_redirected_to customers_path

    Customer.find_by(dni: @customer_new_data[:dni]).as_json.each do |key, value|
      assert_equal @customer_new_data[key.to_sym], value if @customer_new_data.key?(key.to_sym)
    end

  end

  test 'should create customer and return it as json' do
    post :create, customer: @customer_new_data, format: :json
    assert_response :success
    json_response = JSON.parse(response.body)['data']
    Customer.find_by(dni: @customer_new_data[:dni]).as_json.each do |key, value|
      assert_equal json_response[key], value if @customer_new_data.key?(key.to_sym)
    end
  end

  test "should get edit customer" do
    get :edit, id: @customer
    assert_equal @customer, assigns(:customer)
  end

  test "should update customer" do
    assert_record_differences(@customer, @customer_new_data) do
      put :update, id: @customer.id, customer: @customer_new_data
    end
    assert_redirected_to customers_path
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer.id
    end

    assert_redirected_to customers_path
  end

end
