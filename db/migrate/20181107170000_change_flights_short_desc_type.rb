class ChangeFlightsShortDescType < ActiveRecord::Migration[5.2]
  def change
    change_column :flights, :short_desc, :text
  end
end
