class RenameConfigurations < ActiveRecord::Migration[5.1]
  def change
    # Tablename
    rename_table :configurations, :fleets
  end
end
