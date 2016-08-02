require 'test_helper'
require 'pp'

class CoincidencesControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  def setup
    @coincidence          = coincidences(:one)
    @coincidence_new_data = {
      is_ignored: true
    }
    login_user(users(:ross))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:coincidences)
    assert_equal Coincidence.count, assigns(:coincidences).send(:count)
  end

  test 'should get coincidences and return them as json' do
    get :index, format: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal json_response.length, Coincidence.count
  end

  test "should update coincidence" do
    assert_record_differences(@coincidence, @coincidence_new_data) do
      put :update, id: @coincidence.id, coincidence: @coincidence_new_data
    end
    assert_redirected_to coincidences_path
  end

  test "should destroy coincidence" do
    assert_difference('Coincidence.count', -1) do
      delete :destroy, id: coincidences(:one).id
    end

    assert_redirected_to coincidences_path
  end

end
