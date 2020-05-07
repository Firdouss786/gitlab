class ChangeConfigNameInAircraft < ActiveRecord::Migration[5.1]
  def change
    rename_column :aircraft, :configuration_id, :fleet_id
  end
end
