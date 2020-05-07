class RemoveAirportFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :airport_id
  end
end
