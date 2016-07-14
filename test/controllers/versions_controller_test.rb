require 'test_helper'

class VersionsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @version = versions(:trend)
    @vehicle_model = vehicle_models(:focus)
    login_user(users(:ross))
  end

  test 'should get versions filtered by vehicle model' do
    get :index, vehicle_model_id: @vehicle_model.id
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal @vehicle_model.versions.count, body.count

    assert_not_nil body.find { |record| record['id'] == @version.id }
  end

end
