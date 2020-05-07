class MoveActivitiesToStations < ActiveRecord::Migration[5.1]
  def change
    # Remove FK
    remove_foreign_key :activities, name: "fk_activity_activity_location_2"

    # Set the airport ID to that of the station ID
    execute <<-SQL
      UPDATE activities
      JOIN airports
      ON activities.airport_id = airports.id
      JOIN stations
      ON airports.id = stations.airport_id
      SET activities.airport_id = stations.id
    SQL

    # Rename Column
    rename_column :activities, :airport_id, :station_id
  end
end
