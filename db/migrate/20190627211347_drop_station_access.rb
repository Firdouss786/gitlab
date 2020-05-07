class DropStationAccess < ActiveRecord::Migration[6.0]
  def change
    drop_table :station_accesses
  end
end
