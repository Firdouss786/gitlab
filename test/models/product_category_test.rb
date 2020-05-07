require 'test_helper'

class ProductCategoryTest < ActiveSupport::TestCase

  setup do
    @product_category = product_categories(:other)
  end

  test "cannot have duplicate name with same product type" do
    new_category = @product_category.dup
    assert new_category.invalid?
    refute_empty new_category.errors[:name]
  end

end
