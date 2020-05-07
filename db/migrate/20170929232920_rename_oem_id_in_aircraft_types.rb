class RenameOemIdInAircraftTypes < ActiveRecord::Migration[5.1]
  def change
    rename_column :aircraft_types, :oem_id, :manufacturer_id
  end
end
