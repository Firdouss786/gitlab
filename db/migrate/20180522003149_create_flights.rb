class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :vendor_id
      t.string :flight_number
      t.string :airline_code
      t.string :airline_name
      t.string :aircraft_type
      t.string :tail_number
      t.string :flight_status
      t.string :departure_airport_code
      t.string :departure_airport_name
      t.string :departure_city_name
      t.string :departure_country
      t.string :departure_terminal
      t.string :departure_gate
      t.datetime :departure_gate_scheduled_at
      t.datetime :departure_gate_actual_at
      t.datetime :departure_runway_actual_at
      t.string :departure_checkin_counter
      t.integer :departure_delay_reason
      t.string :arrival_airport_code
      t.string :arrival_airport_name
      t.string :arrival_city_name
      t.string :arrival_country
      t.string :arrival_terminal
      t.string :arrival_baggage
      t.string :arrival_gate
      t.datetime :arrival_gate_scheduled_at
      t.datetime :arrival_gate_actual_at
      t.datetime :arrival_runway_actual_at
      t.integer :arrival_delay_reason
      t.integer :seq_number
      t.integer :number_legs
      t.time :flight_time_remaining

      t.timestamps
    end
  end
end
