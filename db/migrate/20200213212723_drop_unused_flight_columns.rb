class DropUnusedFlightColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :flights, :aircraft_type
    remove_column :flights, :tail_number
    remove_column :flights, :origin_airport_name
    remove_column :flights, :origin_city_name
    remove_column :flights, :destination_airport_name
    remove_column :flights, :destination_city_name
    remove_column :flights, :event_code
    remove_column :flights, :summary
    remove_column :flights, :short_desc

    remove_column :flights, :filed_blockout_time
    remove_column :flights, :estimated_blockout_time
    remove_column :flights, :actual_blockout_time
    remove_column :flights, :filed_arrival_time
    remove_column :flights, :filed_blockin_time
    remove_column :flights, :estimated_blockin_time
    remove_column :flights, :actual_blockin_time
  end
end
