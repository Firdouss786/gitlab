class AddIndexeToAirport < ActiveRecord::Migration[5.2]
  def change
    add_index :airports, :icao_code
  end
end
