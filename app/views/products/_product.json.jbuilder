json.extract! product, :id, :part_number, :name, :price, :shelf_life, :description, :product_category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
