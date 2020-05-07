module PasswordValidation
  extend ActiveSupport::Concern

  included do
    has_secure_password validations: false

    before_save :renew_password_expiration_date, if: :password_is_being_changed

    with_options if: :password_is_being_changed do
      validates :password, presence: true
      validates :password, length: { minimum: 10, maximum: 70, message: "must be between 10 and 70 Characters" }
      validates :password, contains_upper_case: true
      validates :password, contains_lower_case: true
      validates :password, contains_digit: true
      validates :password, contains_special_characters: true
    end
  end

  private
    def password_is_being_changed
      will_save_change_to_password_digest?
    end

    def renew_password_expiration_date
      self.password_expires_at = Time.current + 1.year
    end

end
