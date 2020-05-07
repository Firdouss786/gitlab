class AddIndexesToFlights < ActiveRecord::Migration[5.2]
  def change
    add_index :flights, :tail_number
    add_index :flights, :departure_gate_scheduled_at
  end
end
