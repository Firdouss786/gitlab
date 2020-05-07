class AddVerificationBooleanToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :requires_verification, :boolean, default: true
    User.update_all requires_verification: true
  end
end
