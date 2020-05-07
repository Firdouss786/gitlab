module Verification
  extend ActiveSupport::Concern

  included do

    # POST   /verify
    def verify
      if verification_code_valid?
        complete_login
      else
        RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} failed OTP verification"}).save
        flash.now[:alert] = 'Invalid verification code'
        render 'verification_form'
      end
    end

    def verify_user
      if @user.requires_verification? && email_enabled?
        RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} sending OTP code to #{@user.secondary_email}"}).save
        set_user_gid
        mail_verification_code
        flash.now[:notice] = "We've sent a verification code to your email (#{@user.secondary_email})"
        render 'verification_form'
      end
    end

    def verification_recipe
      ROTP::TOTP.new(Rails.application.credentials.ROTP_key_base, issuer: "Firefly")
    end

    def verification_code
      verification_recipe.now
    end

    def verification_code_valid?
      verification_recipe.verify(params[:session][:verification_code], drift_behind: 5.minutes)
    end

    def mail_verification_code
      UserMailer.verification_code(user: @user, verification_code: verification_code).deliver_now
    end
  end

  private
    def set_user_gid
      # TODO: Why is @user_gid not just given to the mailer?
      @user_gid = @user.to_sgid(expires_in: 10.minutes, for: 'verification_code').to_s
    end

    def email_enabled?
      FeatureFlag.get?('email_two_step_verification')
    end

end
