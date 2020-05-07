class AddStateToAirlines < ActiveRecord::Migration[5.1]
  def change
    add_column :airlines, :state, :string, :default => "active"
    add_column :programs, :state, :string, :default => "active"
    add_column :fleets, :state, :string, :default => "active"
    add_column :aircrafts, :state, :string, :default => "active"
  end
end
