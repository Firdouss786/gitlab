class PasswordResetsController < ApplicationController
  layout "landing"
  
  def new
  end

  def edit
    expiring_sgid = params[:id].to_s
    @user = GlobalID::Locator.locate_signed(expiring_sgid, for: 'password_reset')

    if user_unauthorized?
      redirect_to login_path, alert: 'Reset Token Expired'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      log_in @user
      redirect_to root_url, notice: 'Your password has been reset'
    else
      render :edit
    end
  end

  def create
    user = User.find_by(email: params[:password_reset][:email])

    if user
      UserMailer.with(user: user, reset_token: password_reset_token(user)).password_reset.deliver_later
      redirect_to root_url, notice: "Your reset token has been emailed to you"
    else
      redirect_to root_url, alert: "Unable to find email address"
    end
  end

  private
    def user_unauthorized?
      !@user
    end

    def user_params
      params.require(:user).permit(:password)
    end

    def password_reset_token(user)
      user.to_sgid(expires_in: 10.minutes, for: 'password_reset').to_s
    end
end
