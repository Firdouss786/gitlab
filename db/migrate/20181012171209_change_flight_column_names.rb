class ChangeFlightColumnNames < ActiveRecord::Migration[5.2]
  def change
  	rename_column :flights, :departure_airport_code, :origin_airport_code
  	rename_column :flights, :departure_airport_name, :origin_airport_name
  	rename_column :flights, :departure_city_name, :origin_city_name

  	rename_column :flights, :departure_gate_scheduled_at, :out_scheduled_at
  	rename_column :flights, :departure_gate_actual_at, :out_actual_at
  	rename_column :flights, :departure_runway_actual_at, :off_actual_at

  	rename_column :flights, :arrival_airport_code, :destination_airport_code
  	rename_column :flights, :arrival_airport_name, :destination_airport_name
  	rename_column :flights, :arrival_city_name, :destination_city_name

  	rename_column :flights, :arrival_gate_scheduled_at, :in_scheduled_at
  	rename_column :flights, :arrival_gate_actual_at, :in_actual_at
  	rename_column :flights, :arrival_runway_actual_at, :on_actual_at

  	rename_column :flights, :departure_airport_id, :origin_airport_id
  	rename_column :flights, :arrival_airport_id, :destination_airport_id
  end
end
