class AddStateToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :flight_subscriptions, :state, :string
  end
end
