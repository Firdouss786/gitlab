class AddEventCodeToFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :event_code, :string
  end
end
