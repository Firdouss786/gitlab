class AddFlightToActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :flight, foreign_key: true
  end
end
