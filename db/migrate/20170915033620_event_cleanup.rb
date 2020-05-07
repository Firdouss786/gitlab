class EventCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
		rename_column :event, :event_id, :id

    rename_column :event, :event_type, :category
    rename_column :event, :event_status, :is_open
    rename_column :event, :event_user_user_id, :user_id
    rename_column :event, :event_description, :description
    rename_column :event, :event_name, :name
    rename_column :event, :event_station_station_id, :station_id

    # Timestamps
    model_name = "event"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :event, :events
  end
end
