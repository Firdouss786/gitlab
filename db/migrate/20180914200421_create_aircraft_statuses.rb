class CreateAircraftStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :aircraft_statuses do |t|
      t.string :state
      t.references :aircraft, foreign_key: true
      t.integer :current_flight_id, index: true
      t.integer :current_activity_id, index: true

      t.timestamps
    end
  end
end
