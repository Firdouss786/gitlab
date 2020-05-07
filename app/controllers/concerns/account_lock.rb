module AccountLock
  extend ActiveSupport::Concern

  included do
    def notify_of_lock
      if @user.locked?
        RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} account is locked"}).save
        redirect_to login_url, alert: "Your account has been locked. Please contact #{Firefly::SUPPORT_EMAIL} for help unlocking your account."
      end
    end
  end
end
