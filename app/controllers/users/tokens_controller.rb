class Users::TokensController < ApplicationController
  before_action :set_user, only: [:new, :create]

  # /users/:user_id/tokens/new
  def new
    authorize! :new, @user
  end

  # /users/:user_id/tokens
  def create
    authorize! :create, @user
    @user.assign_attributes(:token => generate_secure_token,:reason_for_token => token_params[:reason_for_token])

    respond_to do |format|
      if user_is_me? && @user.save
        ApiMailer.api_creation(@user,@user.reason_for_token).deliver_later
        format.html { redirect_to new_user_token_path(@user), notice: "Your new API token is #{@user.token}" }
      else
        format.html { redirect_to new_user_token_path(@user), notice: 'You can only generate an API token for your own user' }
      end
    end
  end

  private
    def set_user
      @user = User.find(token_params[:user_id])
    end

    def token_params
      params.permit(:reason_for_token, :user_id)
    end

    def user_is_me?
      @user == Current.user
    end

    def generate_secure_token
      SecureRandom.hex(15).upcase
    end
end
