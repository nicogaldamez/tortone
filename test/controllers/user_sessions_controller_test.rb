require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  include Sorcery::TestHelpers::Rails::Controller

  setup do
    @me = users(:ross)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should create session" do
    assert_not logged_in?
    post :create, email: @me.email, password: 'friends'
    assert logged_in?
    assert_equal @me, assigns(:user)
    assert_redirected_to root_path
  end

  test 'should not create session' do
    assert_not logged_in?
    post :create, email: @me.email, password: 'wrong'
    assert_not logged_in?
  end

  test "should get destroy" do
    login_user(@me)

    delete :destroy
    assert_not logged_in?
    assert_redirected_to login_path
  end

  test 'should not destroy session' do
    assert_not logged_in?
    delete :destroy
    assert_not logged_in?
    assert_redirected_to login_path
  end

end
