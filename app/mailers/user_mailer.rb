class UserMailer < ApplicationMailer
  default from: 'firefly@thalesinflight.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @user = params[:user]
    @reset_token = params[:reset_token]

    mail to: @user.email, subject: 'Servo Password Reset Request'
  end

  def verification_code(user:, verification_code:)
    @verification_code = verification_code
    @user = user
    mail(to: user.secondary_email, subject: "Code: #{verification_code} – Your Servo Verification Code")
  end

  def invite_user(user:, password_token:)
    @password_token = password_token
    @user = user
    mail(to: user.email, subject: "You have a new Servo account")
  end
end
