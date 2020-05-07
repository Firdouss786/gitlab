class ServiceablePartTag < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :serviceable_part_tag, :serviceable_part_tag_id, :id

    rename_column :serviceable_part_tag, :manufacturer_part_no, :manufacturer_part_number
    rename_column :serviceable_part_tag, :manufacturer_part_no_bar_code, :manufacturer_part_number_barcode
    rename_column :serviceable_part_tag, :serial_no, :serial_number
    rename_column :serviceable_part_tag, :serial_no_bar_code, :serial_number_barcode
    rename_column :serviceable_part_tag, :part_name, :part_name
    rename_column :serviceable_part_tag, :manufacturer, :manufacturer
    rename_column :serviceable_part_tag, :modification_status, :modification_status
    rename_column :serviceable_part_tag, :revision_status, :revision_status
    rename_column :serviceable_part_tag, :batch_no, :batch_number
    rename_column :serviceable_part_tag, :shelf_life_expiry, :shelf_life_expiry
    rename_column :serviceable_part_tag, :name, :user_name

    # Remove
    remove_column :serviceable_part_tag, :purchase_order
    remove_column :serviceable_part_tag, :last_condition

    # Timestamps
    model_name = "serviceable_part_tag"

    timestamp_name = "date"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :serviceable_part_tag, :serviceable_part_tags
  end
end
