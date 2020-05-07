class SetPasswordExpiryForAllUsers < ActiveRecord::Migration[5.2]
  def change
    User.update_all password_expires_at: DateTime.now
  end
end
