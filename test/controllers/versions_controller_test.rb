require 'test_helper'

class VersionsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @version = versions(:trend)
    @vehicle_model = vehicle_models(:focus)
    @version_new_data = { name: 'New version', vehicle_model_id: @vehicle_model.id }
    login_user(users(:ross))
  end

  test 'should get versions filtered by vehicle model' do
    get :index, vehicle_model_id: @vehicle_model.id
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal @vehicle_model.versions.count, body.count

    assert_not_nil body.find { |record| record['id'] == @version.id }
  end

  test 'should create version and return it as json' do
    post :create, version: @version_new_data, format: :json
    assert_response :success
    json_response = JSON.parse(response.body)['data']
    Version.find_by(name: @version_new_data[:name]).as_json.each do |key, value|
      assert_equal json_response[key], value if @version_new_data.key?(key.to_sym)

    end
  end

end
