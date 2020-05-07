class AddAirlineToIssues < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :airline, foreign_key: true
  end
end
