require 'test_helper'

class VehicleModelsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @vehicle_model = vehicle_models(:focus)
    @brand = brands(:ford)
    login_user(users(:ross))
  end

  test 'should get vehicle models filtered by brand' do
    get :index, brand_id: @brand.id
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal @brand.vehicle_models.count, body.count

    assert_not_nil body.find { |record| record['id'] == @vehicle_model.id }
  end

end
