class AddressCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :address, :address_id, :id

    rename_column :address, :address_zip, :zip
    rename_column :address, :address_street1, :street1
    rename_column :address, :address_street2, :street2
    rename_column :address, :address_city, :city
    rename_column :address, :address_country, :country
    rename_column :address, :address_state, :state
    rename_column :address, :address_phone, :phone

    # Timestamps
    model_name = "address"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :address, :addresses
  end
end
