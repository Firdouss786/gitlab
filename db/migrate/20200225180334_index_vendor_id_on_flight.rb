class IndexVendorIdOnFlight < ActiveRecord::Migration[6.0]
  def change
  	add_index :flights, :vendor_id
  end
end
