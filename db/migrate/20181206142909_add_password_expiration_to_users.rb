class AddPasswordExpirationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_expires_at, :datetime
  end
end
