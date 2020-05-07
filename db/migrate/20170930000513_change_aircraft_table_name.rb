class ChangeAircraftTableName < ActiveRecord::Migration[5.1]
  def change
    # Tablename
    rename_table :aircraft, :aircrafts
  end
end
