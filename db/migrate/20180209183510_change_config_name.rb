class ChangeConfigName < ActiveRecord::Migration[5.1]
  def change
    rename_column :product_allotments, :configuration_id, :fleet_id
  end
end
