class AddExpiredAtToCertificates < ActiveRecord::Migration[5.1]
  def change
    add_column :certificates, :expired_at, :datetime
  end
end
