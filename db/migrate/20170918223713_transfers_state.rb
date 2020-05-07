class TransfersState < ActiveRecord::Migration[5.1]
  def change

    add_column :transfers, :from_state, :string
    add_column :transfers, :to_state, :string

    # FROM state
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations
      ON stock_locations.id = transfers.source_stock_location_id
      SET transfers.from_state = stock_locations.state
    SQL

    # Creations do not have a source stock
    execute <<-SQL
      UPDATE transfers
      SET transfers.from_state = "CREATION"
      WHERE transfers.category = "CREATION"
    SQL

    # Everything else SHOULD have a source stock ID but doesn't. Lets set it to unknown (must have been a bug in Servo)
    execute <<-SQL
      UPDATE transfers
      SET transfers.from_state = "UNKNOWN"
      WHERE transfers.source_stock_location_id is NULL
      AND transfers.category != "CREATION"
    SQL

    # TO state
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations
      ON stock_locations.id = transfers.destination_stock_location_id
      SET transfers.to_state = stock_locations.state
    SQL

    # Everything left has an unknown destination state (must be another bug in Servo)
    execute <<-SQL
      UPDATE transfers
      SET transfers.to_state = "UNKNOWN"
      WHERE transfers.to_state is NULL
    SQL

  end

end
