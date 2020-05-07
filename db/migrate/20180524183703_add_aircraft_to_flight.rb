class AddAircraftToFlight < ActiveRecord::Migration[5.2]
  def change
    add_reference :flights, :aircraft, foreign_key: true
  end
end
