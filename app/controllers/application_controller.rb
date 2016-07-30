class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  
  private

  def not_authenticated
    redirect_to login_path, alert: "Por favor, inicie sesión"
  end
  
end
