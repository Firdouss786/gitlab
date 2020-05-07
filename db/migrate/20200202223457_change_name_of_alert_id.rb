class ChangeNameOfAlertId < ActiveRecord::Migration[6.0]
  def change
    rename_column :flight_subscriptions, :alert_id, :vendor_subscription_id
  end
end
