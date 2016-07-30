class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  
  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:root, notice: t(:login_successful))
    else
      flash[:error] = t(:login_error)
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: t(:logout_successful))
  end
end
