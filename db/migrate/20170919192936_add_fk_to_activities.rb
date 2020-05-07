class AddFkToActivities < ActiveRecord::Migration[5.1]
  def change
    change_column :activities, :station_id, :bigint

    # Don't know why this doesn't work. Not the end of the world but station_id in activities has no FK
    # add_foreign_key :activities, :stations
  end
end
