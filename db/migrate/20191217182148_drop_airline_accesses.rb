class DropAirlineAccesses < ActiveRecord::Migration[6.0]
  def change
    drop_table :airline_accesses
  end
end
