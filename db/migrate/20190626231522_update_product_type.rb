class UpdateProductType < ActiveRecord::Migration[6.0]
  def change
    ProductCategory.where(product_type: "CONSUMMABLE").update_all('product_type = "CONSUMABLE"')
  end
end
