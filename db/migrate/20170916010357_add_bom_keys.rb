class AddBomKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :product_allotments, :configurations
    add_foreign_key :product_allotments, :products
  end
end
