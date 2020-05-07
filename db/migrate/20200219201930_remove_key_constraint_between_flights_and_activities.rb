class RemoveKeyConstraintBetweenFlightsAndActivities < ActiveRecord::Migration[6.0]
  def change
  	remove_foreign_key :activities, :flights
  end
end
