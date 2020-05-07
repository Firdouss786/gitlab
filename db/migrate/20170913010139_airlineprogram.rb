class Airlineprogram < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :airlineprogram, :airlineprogram_id, :id

    rename_column :airlineprogram, :airlineprogram_mccemail, :mcc_email
    rename_column :airlineprogram, :airlineprogram_repairordernote, :repair_order_note
    rename_column :airlineprogram, :airlineprogram_group1, :mailing_group_1
    rename_column :airlineprogram, :airlineprogram_group2, :mailing_group_2
    rename_column :airlineprogram, :airlineprogram_group3, :mailing_group_3
    rename_column :airlineprogram, :airlineprogram_airline_airline_id, :airline_id
    rename_column :airlineprogram, :airlineprogram_mainbase_airport_id, :airport_id

    # Remove
    remove_foreign_key :airlineprogram, name: "fk_airlineprogram_airlineprogram_repairprogram_21"
    remove_column :airlineprogram, :airlineprogram_repairprogram_repairprogram_id

    # Timestamps
    model_name = "airlineprogram"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :airlineprogram, :programs
  end
end
