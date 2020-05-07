class AddAircraftStatusToFlights < ActiveRecord::Migration[5.2]
  def change
    add_reference :flights, :aircraft_status, foreign_key: true
  end
end
