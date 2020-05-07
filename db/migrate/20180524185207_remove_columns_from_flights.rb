class RemoveColumnsFromFlights < ActiveRecord::Migration[5.2]
  def change
    remove_column :flights, :airline_code
    remove_column :flights, :airline_name
    remove_column :flights, :flight_status
    remove_column :flights, :departure_country
    remove_column :flights, :departure_terminal
    remove_column :flights, :departure_gate
    remove_column :flights, :departure_checkin_counter
    remove_column :flights, :departure_delay_reason
    remove_column :flights, :arrival_country
    remove_column :flights, :arrival_terminal
    remove_column :flights, :arrival_baggage
    remove_column :flights, :arrival_gate
    remove_column :flights, :arrival_delay_reason
    remove_column :flights, :seq_number
    remove_column :flights, :number_legs
    remove_column :flights, :flight_time_remaining
  end
end
