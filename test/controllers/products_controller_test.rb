require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @product = products(:dual_usb)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { name: 'Microphone', part_number: '111077-0G67', price: @product.price, product_category_id: @product.product_category_id, shelf_life: @product.shelf_life } }
    end

    assert_redirected_to products_path
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { name: "Microphone" } }
    assert_redirected_to products_path
  end

  # test "should destroy product" do
  #   assert_difference('Product.count', -1) do
  #     delete product_url(@product)
  #   end
  #
  #   assert_redirected_to products_url
  # end

end
