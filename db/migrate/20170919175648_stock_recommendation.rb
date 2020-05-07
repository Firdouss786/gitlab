class StockRecommendation < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :stock_recommendation, :stock_recommendation_id, :id

    rename_column :stock_recommendation, :stock_recommendation_productsubtype_productsubtype_id, :product_id
    rename_column :stock_recommendation, :stock_recommendation_quantity, :recommended_quantity
    rename_column :stock_recommendation, :stock_id, :stock_location_id

    # Timestamps
    model_name = "stock_recommendation"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :stock_recommendation, :level_recommendations
  end
end
