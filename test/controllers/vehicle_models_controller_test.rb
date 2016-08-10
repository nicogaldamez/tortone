require 'test_helper'

class VehicleModelsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @vehicle_model = vehicle_models(:focus)
    @brand = brands(:ford)
    @vehicle_model_new_data = { name: 'New Version', brand_id: brands(:volkswagen).id }
    login_user(users(:ross))
  end

  test 'should should get index' do
    get :index, format: :html
    assert_response :success
    assert_not_nil assigns(:vehicle_models)
    assert_equal VehicleModel.count, assigns(:vehicle_models).send(:count)
  end

  test "should get new vehicle model" do
    get :new
    assert_not_nil assigns(:vehicle_model)
  end

  test "should create vehicle model" do
    assert_difference('VehicleModel.count', 1) do
      post :create, vehicle_model: @vehicle_model_new_data, format: :html
    end
    assert_redirected_to vehicle_models_path
    assert_not_nil VehicleModel.find_by(name: @vehicle_model_new_data[:name])
  end

  test 'should get vehicle models filtered by brand' do
    get :index, brand_id: @brand.id, format: :json
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal @brand.vehicle_models.count, body.count

    assert_not_nil body.find { |record| record['id'] == @vehicle_model.id }
  end

  test 'should create model and return it as json' do
    post :create, vehicle_model: @vehicle_model_new_data, format: :json
    assert_response :success
    json_response = JSON.parse(response.body)['data']
    VehicleModel.find_by(name: @vehicle_model_new_data[:name]).as_json.each do |key, value|
      assert_equal json_response[key], value if @vehicle_model_new_data.key?(key.to_sym)
    end
  end

  test "should search vehicle model" do
    get :search, query: @vehicle_model.name
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal [{ 'id' => @vehicle_model.id, 'name' => @vehicle_model.name }],
                   body['records']
  end

  test "should search vehicle model and return it with the brand" do
    get :search, query: @vehicle_model.name, with_brand: true
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal [{ 'id' => @vehicle_model.id, 'name' => "#{@vehicle_model.brand.name} #{@vehicle_model.name}",
                    'brand_id' => @vehicle_model.brand_id }], body['records']
  end

  test "should get edit vehicle_model" do
    get :edit, id: @vehicle_model
    assert_equal @vehicle_model, assigns(:vehicle_model)
  end

  test "should update vehicle model" do
    assert_record_differences(@vehicle_model, @vehicle_model_new_data) do
      put :update, id: @vehicle_model.id, vehicle_model: @vehicle_model_new_data
    end
    @vehicle_model.reload

    assert_redirected_to vehicle_models_path
  end

  test "should destroy vehicle model" do
    assert_difference('VehicleModel.count', -1) do
      delete :destroy, id: vehicle_models(:with_no_relationships).id
    end

    assert_redirected_to vehicle_models_path
  end

end
