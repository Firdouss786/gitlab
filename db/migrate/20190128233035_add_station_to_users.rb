class AddStationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :home_station, foreign_key: { to_table: :stations }, index: true
  end
end
