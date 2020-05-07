# Preview all emails at http://localhost:3000/rails/mailers/otp_mailer
class OtpMailerPreview < ActionMailer::Preview

    def otp_mail_preview
        OtpMailer.otp_email(User.first.email, "toto")
      end

end
