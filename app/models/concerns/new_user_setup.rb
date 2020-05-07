module NewUserSetup
  extend ActiveSupport::Concern

  included do
    before_create :force_password_reset
    after_create :send_temporary_token
  end

  private

    def send_temporary_token
      unless requires_new_user_setup == false
        UserMailer.invite_user(user: self, password_token: password_token(self)).deliver_later
      end
    end

    def force_password_reset
      unless requires_new_user_setup == false
        self.password_expires_at = Time.current - 1.second
      end
    end

    def password_token(user)
      user.to_sgid(expires_in: 2.days, for: 'password_reset').to_s
    end

end
