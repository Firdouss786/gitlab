class MoveCategoryFromSiToProduct < ActiveRecord::Migration[5.1]
#   def change
#     add_column :products, :classification, :string
#     remove_column :stock_items, :category
#
#     execute <<-SQL
#       UPDATE products
#       JOIN product_categories
#       ON products.product_category_id = product_categories.id
#       SET products.classification = product_categories.product_type
#     SQL
#
#     # Consumable was spelt wrong in original DB
#     execute <<-SQL
#       UPDATE products
#       SET products.classification = "CONSUMABLE"
#       WHERE products.classification = "CONSUMMABLE"
#     SQL
#
#     remove_column :product_categories, :product_type
#   end
end
