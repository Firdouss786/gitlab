module PasswordReset
  extend ActiveSupport::Concern

  included do
    def reset_password
      if @user.password_expired?
        RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} password expired, redirecting to new password page"}).save
        redirect_to new_password_reset_path
      end
    end
  end

end
