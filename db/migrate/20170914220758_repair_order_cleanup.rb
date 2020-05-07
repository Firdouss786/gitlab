class RepairOrderCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :repair_order, :ro_id, :id

    rename_column :repair_order, :name, :user_name
    rename_column :repair_order, :ronumber, :ro_number
    rename_column :repair_order, :price, :price
    rename_column :repair_order, :vendor, :vendor
    rename_column :repair_order, :shippingaddress, :shipping_address
    rename_column :repair_order, :returnaddress, :return_address
    rename_column :repair_order, :comments, :repair_comment
    rename_column :repair_order, :carriername, :carrier_name
    rename_column :repair_order, :aircraft, :aircraft
    rename_column :repair_order, :reasonforremoval, :removal_reason
    rename_column :repair_order, :partnum, :part_number
    rename_column :repair_order, :partdesc, :part_description
    rename_column :repair_order, :serialnum, :serial_number
    rename_column :repair_order, :taskdesc, :task_description
    rename_column :repair_order, :additionalinfo, :airway_bill_comment
    rename_column :repair_order, :removeddate, :removal_date
    rename_column :repair_order, :promisedbydate, :promised_at
    rename_column :repair_order, :ro_expired, :expired

    # Remove
    remove_column :repair_order, :linenum
    remove_column :repair_order, :warranty
    remove_column :repair_order, :freightonboard
    remove_column :repair_order, :termsconditions
    remove_column :repair_order, :transportationtype

    # Timestamps
    model_name = "repair_order"

    timestamp_name = "ro_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :repair_order, :repair_orders
  end
end
