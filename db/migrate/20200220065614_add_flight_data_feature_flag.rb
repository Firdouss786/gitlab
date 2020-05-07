class AddFlightDataFeatureFlag < ActiveRecord::Migration[6.0]
  def change
    FeatureFlag.create(:name => "flight_data", :enabled => 1)
  end
end
