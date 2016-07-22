require 'test_helper'

class BuyersControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @buyer = buyers(:carlos)
    @buyer_new_data = {first_name: 'Nuevo', last_name: 'Cliente',
                       email: 'nuevo@buyer.com', phones: '3123123213/123123123',
                       is_hdi: true, has_automatic_transmission: true,
                       min_price: 200000, max_price: 300000, notes: 'Notas'
                      }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:presenter)
    assert_equal Buyer.count, assigns(:presenter).send(:buyers).send(:count)
  end

  test "should get new buyer" do
    get :new
    assert_not_nil assigns(:buyer)
  end

  test "should create buyer" do
    assert_difference('Buyer.count', 1) do
      post :create, buyer: @buyer_new_data
    end
    assert_redirected_to buyers_path

    Buyer.find_by(email: @buyer_new_data[:email]).as_json.each do |key, value|
      assert_equal @buyer_new_data[key.to_sym], value, "No guardó correctamente #{key}" if @buyer_new_data.key?(key.to_sym)
    end
  end

  test "should get edit buyer" do
    get :edit, id: @buyer
    assert_equal @buyer, assigns(:buyer)
  end

  test "should update buyer" do
    assert_record_differences(@buyer, @buyer_new_data) do
      put :update, id: @buyer.id, buyer: @buyer_new_data
    end
    assert_redirected_to buyers_path
  end

  test "should destroy buyer" do
    assert_difference('Buyer.count', -1) do
      delete :destroy, id: @buyer.id
    end

    assert_redirected_to buyers_path
  end

end

