require 'test_helper'

class VehicleModelsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @vehicle_model = vehicle_models(:focus)
    @brand = brands(:ford)
    @vehicle_model_new_data = { name: 'New Version', brand_id: @brand.id }
    login_user(users(:ross))
  end

  test 'should get vehicle models filtered by brand' do
    get :index, brand_id: @brand.id
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

end
