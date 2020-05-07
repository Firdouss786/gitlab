class UnserviceablePartTag < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :unserviceable_part_tag, :unserviceable_part_tag_id, :id

    rename_column :unserviceable_part_tag, :reason_for_removal, :reason_for_removal
    rename_column :unserviceable_part_tag, :removed_date, :removed_date
    rename_column :unserviceable_part_tag, :removed_during_task, :removed_during_task
    rename_column :unserviceable_part_tag, :work_order_number, :work_order_number
    rename_column :unserviceable_part_tag, :aircraft, :aircraft
    rename_column :unserviceable_part_tag, :unserviceable_modification_status, :unserviceable_modification_status
    rename_column :unserviceable_part_tag, :unserviceable_revisionstatus, :unserviceable_revisionstatus
    rename_column :unserviceable_part_tag, :repair_order_number, :repair_order_number
    rename_column :unserviceable_part_tag, :unserviceable_part_name, :unserviceable_part_name
    rename_column :unserviceable_part_tag, :removed_from_position, :removed_from_position
    rename_column :unserviceable_part_tag, :unserviceable_manufacturer_part_number, :unserviceable_manufacturer_part_number
    rename_column :unserviceable_part_tag, :unserviceable_manufacturer, :unserviceable_manufacturer
    rename_column :unserviceable_part_tag, :unserviceable_serial_number, :unserviceable_serial_number
    rename_column :unserviceable_part_tag, :name, :user_name

    # Remove
    remove_column :unserviceable_part_tag, :ac_afh
    remove_column :unserviceable_part_tag, :ac_cycles

    # Timestamps
    model_name = "unserviceable_part_tag"

    timestamp_name = "date"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime

    # There is a row in this table which somehow has a NULL timestamp
    execute "UPDATE #{model_name} SET date = DATE_FORMAT(NOW(),\"%Y-%m-%d 00:00:00\") where id = 1"

    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :unserviceable_part_tag, :unserviceable_part_tags
  end
end
