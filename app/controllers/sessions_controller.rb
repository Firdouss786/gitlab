class SessionsController < ApplicationController
  include AccountLock, PasswordReset, Verification
  layout "landing"

  before_action :set_user, except: [:new, :destroy]

  def new
  end

  def create
    # We check if the password has expired first, as this means a password hash has not been set (initial rollout)
    unless reset_password
      if credentials_are_valid?
        RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} entered a valid password"}).save
        notify_of_lock || reset_password || verify_user || complete_login
      else
        RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} entered an incorrect password"}).save
        flash.now[:alert] = 'Incorrect Password. Try the \'Reset your password\' link bellow.'
        render 'new'
      end
    end
  end

  def destroy
    log_out
  end

  private
    def set_user
      # TODO: I'm not sure we should allow the find_by_email lookup outside the initial login form.
      # This allows it for password reset, and verification also
      @user = find_by_email || find_by_gid
      unless @user
        flash.now[:alert] = "User does not exist. Please email #{Firefly::SUPPORT_EMAIL} for account creation"
        render 'new'
      end
    end

    def user_params
      params.require(:session).permit(:email, :password, :user_gid)
    end

    def find_by_email
      if user_params[:email]
        User.find_by(email: user_params[:email].downcase)
      end
    end

    def find_by_gid
      if user_params[:user_gid]
        GlobalID::Locator.locate_signed(user_params[:user_gid], for: 'verification_code')
      end
    end

    def credentials_are_valid?
      @user.authenticate user_params[:password]
    end

    def complete_login
      RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} login complete, redirecting to user home page"}).save
      log_in @user
      redirect_to session.delete(:return_to) || root_url
    end

end
