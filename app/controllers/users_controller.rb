class UsersController < MainController
  before_action :set_user, only: [:edit, :update]

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Tu perfil ha sido actualizado con éxito'
    else
      flash[:error] = t(:error)
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
