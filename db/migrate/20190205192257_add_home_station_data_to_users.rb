class AddHomeStationDataToUsers < ActiveRecord::Migration[6.0]
  def change
    execute <<-SQL
      UPDATE users
        JOIN airports
        ON users.airport_id = airports.id
        JOIN stations
        ON airports.id = stations.airport_id
        SET users.home_station_id = stations.id
    SQL
  end
end
