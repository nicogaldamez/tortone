require 'test_helper'

class BrandsControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller

  def setup
    login_user(users(:ross))
  end

  test 'should create brand and return it as json' do
    post :create, brand: { name: 'New brand' }, format: :json
    assert_response :success
    json_response = JSON.parse(response.body)['data']
    json_response[:name] = 'New brand'
  end

end
