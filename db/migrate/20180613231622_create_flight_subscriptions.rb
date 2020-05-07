class CreateFlightSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :flight_subscriptions do |t|
      t.integer :alert_id
      t.references :aircraft, foreign_key: true

      t.timestamps
    end
    add_index :flight_subscriptions, :alert_id
  end
end
