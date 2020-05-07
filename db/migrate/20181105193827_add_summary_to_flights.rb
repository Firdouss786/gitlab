class AddSummaryToFlights < ActiveRecord::Migration[5.2]
  def change
    add_column :flights, :summary, :string
    add_column :flights, :short_desc, :string
  end
end
