class CertificateData < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :certificate_data, :certificatedata_id, :id

    rename_column :certificate_data, :certificatedata_expired, :expired
    rename_column :certificate_data, :certificatedata_filename, :filename
    rename_column :certificate_data, :certificatedata_number, :reference
    rename_column :certificate_data, :certificatedata_type, :governance
    rename_column :certificate_data, :certificatedata_stock_item_stock_item_id, :stock_item_id
    rename_column :certificate_data, :certificatedata_hdfsname, :hdfs_filename

    # Timestamps
    model_name = "certificate_data"

    timestamp_name = "certificatedata_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :certificate_data, :certificates
  end
end
