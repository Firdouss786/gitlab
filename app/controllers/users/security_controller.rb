class Users::SecurityController < ApplicationController
  before_action :set_user, only: [:index, :update]

  # GET /users/:user_id/security
  def index
  end

  # PATCH /users/:user_id/security
  def update
    authorize! :update, @user
    @user.update(user_params)
    redirect_to user_security_path @user
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:requires_verification, :locked)
    end

end
