require 'test_helper'
require 'pp'
class CustomersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @customer = customers(:carlos)
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
  end

  test "should create customer" do
    assert_difference('Customer.count', 1) do
      post :create, customer: {first_name: 'Nuevo',
                               last_name: 'Cliente',
                               email: 'nuevo@cliente.com',
                               phones: '3123123213/123123123',
                               dni: '30876960',
                               address: '48 1488',
                               description: 'Este es el nuevo cliente'
                              }
    end

    assert_redirected_to customers_path
  end

  test "should get edit customer" do
    get :edit, id: @customer
    assert_equal @customer, assigns(:customer)
  end

  test "should update customer" do
    new_first_name  = 'Nuevo Nombre'
    new_last_name   = 'Nuevo Apellido'
    new_email       = 'Nuevo Email'
    new_phones      = 'Nuevos Teléfonos'
    new_dni         = 'Nuevo DNI'
    new_address     = 'Nuevo Domicilio'
    new_description = 'Nueva Descripción'

    put :update, id: @customer.id, customer: {
                                     first_name: new_first_name,
                                     last_name: new_last_name,
                                     email: new_email,
                                     phones: new_phones,
                                     dni: new_dni,
                                     address: new_address,
                                     description: new_description
                            }

    assert_redirected_to customers_path

    @customer.reload
    assert_equal new_first_name, @customer.first_name
    assert_equal new_last_name, @customer.last_name
    assert_equal new_email, @customer.email
    assert_equal new_phones, @customer.phones
    assert_equal new_dni, @customer.dni
    assert_equal new_address, @customer.address
    assert_equal new_description, @customer.description
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer.id
    end

    assert_redirected_to customers_path
  end

end
