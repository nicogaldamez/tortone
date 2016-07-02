require 'test_helper'
require 'pp'

class UsersControllerTest < ActionController::TestCase

  include Sorcery::TestHelpers::Rails::Controller
  
  def setup
    login_user(users(:ross))
    @current_user = users(:ross)
  end
  
  test 'should get logged_user' do
    get :edit
    assert_response :success
    assert_equal @current_user, assigns(:user)
  end
  
  # TODO: mejorar este test. Se podría testear que permite login con nueva contraseña
  test "should update current_user password" do
    new_password              = 'Nueva clave'
    new_password_confirmation = 'Nueva clave'
    user_params = { password: new_password, password_confirmation: new_password_confirmation }
    
    patch :update, user: user_params
    
    assert_redirected_to root_path
  end

end
