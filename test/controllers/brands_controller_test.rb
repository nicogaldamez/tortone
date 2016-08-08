require 'test_helper'

class BrandsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller


  def setup
    login_user(users(:ross))
    @brand = brands(:ford)
  end

  test 'should should get index' do
    get :index, format: :html
    assert_response :success
    assert_not_nil assigns(:brands)
    assert_equal Brand.count, assigns(:brands).send(:count)
  end

  test "should get new brand" do
    get :new
    assert_not_nil assigns(:brand)
  end

  test "should create brand" do
    assert_difference('Brand.count', 1) do
      post :create, brand: { name: 'New Brand' }, format: :html
    end
    assert_redirected_to brands_path
    assert_not_nil Brand.find_by(name: 'New Brand')
  end

  test 'should create brand and return it as json' do
    post :create, brand: { name: 'New brand' }, format: :json
    assert_response :success
    json_response = JSON.parse(response.body)['data']
    json_response[:name] = 'New brand'
  end

  test "should get edit brand" do
    get :edit, id: @brand
    assert_equal @brand, assigns(:brand)
  end

  test "should update brand" do
    assert_record_differences(@brand, { name: 'New Name' }) do
      put :update, id: @brand.id, brand: { name: 'New Name' }
    end
    @brand.reload

    assert_equal 'New Name', @brand.name
    assert_redirected_to brands_path
  end

  test "should destroy brand" do
    assert_difference('Brand.count', -1) do
      delete :destroy, id: brands(:with_no_relationships).id
    end

    assert_redirected_to brands_path
  end

end
