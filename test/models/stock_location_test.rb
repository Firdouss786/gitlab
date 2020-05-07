require 'test_helper'

class StockLocationTest < ActiveSupport::TestCase
  test "Should Create Stock Location" do
    assert_difference('StockLocation.count') do
      @stock_location = stock_locations(:lhr)

      StockLocation.create!(
        category: @stock_location.category,
        name: @stock_location.name,
        parent: @stock_location.parent,
        parent_type: @stock_location.parent_type
      )
    end
  end
end
