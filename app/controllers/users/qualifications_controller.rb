class Users::QualificationsController < ApplicationController
  before_action :set_user, only: [:index, :update]

  # GET /users/:user_id/qualifications
  def index
  end

  # PATCH /users/:user_id/qualifications
  def update
    authorize! :update, @user
    @user.update(user_params)
    redirect_to user_qualifications_path @user
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:user_src_number)
    end

end
