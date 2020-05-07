require 'test_helper'

class TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @stock_location = stock_locations(:lhr)
  end

  test "stock item will mutate from serviceable to inspecting at the same location" do
    stock_item = stock_items(:serviceable)
    assert stock_item.serviceable?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "inspecting", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.inspecting?
  end

  test "stock item will mutate from serviceable to quarantined at the same location" do
    stock_item = stock_items(:serviceable)
    assert stock_item.serviceable?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "quarantined", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.quarantined?
  end

  test "stock item will mutate from serviceable to unserviceable at the same location" do
    stock_item = stock_items(:serviceable)
    assert stock_item.serviceable?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: {transfer: { destination_state: "unserviceable", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.unserviceable?
  end

  test "stock item will mutate from serviceable to installed at the same location" do
    stock_item = stock_items(:serviceable)
    assert stock_item.serviceable?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "installed", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.installed?
  end

  test "stock item will not mutate from serviceable to any other invalid states at the same location" do
    stock_item = stock_items(:serviceable)
    assert stock_item.serviceable?
    invalid_states = (StockItem.states.values -  StockItem::ServiceableState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end  
  end

  test "stock item will mutate from inspecting state to serviceable" do
      stock_item = stock_items(:inspecting)
      assert stock_item.inspecting?
        assert_difference 'Transfer.count', 1 do
          post transfers_url, params: { transfer: { destination_state: "serviceable", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
        end
      assert stock_item.reload.serviceable?
  end

  test "stock item will mutate from inspecting state to unserviceable" do
      stock_item = stock_items(:inspecting)
      assert stock_item.inspecting?
        assert_difference 'Transfer.count', 1 do
          post transfers_url, params: { transfer: { destination_state: "unserviceable", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
        end
      assert stock_item.reload.unserviceable?
  end

  test "stock item will mutate from inspecting state to quarantined" do
      stock_item = stock_items(:inspecting)
      assert stock_item.inspecting?
        assert_difference 'Transfer.count', 1 do
          post transfers_url, params: { transfer: { destination_state: "quarantined", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
        end
      assert stock_item.reload.quarantined?
  end

  test "stock item will not mutate from inspecting state to any other unwanted state" do
    stock_item = stock_items(:inspecting)
    assert stock_item.inspecting?
    invalid_states = (StockItem.states.values -  StockItem::InspectingState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end
  end

  test "stock item will mutate from quarantined state to inspecting" do
    stock_item = stock_items(:quarantined)
    assert stock_item.quarantined?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "inspecting", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.inspecting?
  end

  test "stock item will mutate from quarantined state to unserviceable" do
    stock_item = stock_items(:quarantined)
    assert stock_item.quarantined?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "unserviceable", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.unserviceable?
  end

  test "stock item will not mutate from quarantined state to any other unwanted state" do
    stock_item = stock_items(:quarantined)
    assert stock_item.quarantined?
    invalid_states = (StockItem.states.values -  StockItem::QuarantinedState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end
  end

  test "stock item will mutate from unserviceable state to transiting" do
    stock_item = stock_items(:unserviceable)
    assert stock_item.unserviceable?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "transiting", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.transiting?
  end

  test "stock item will mutate from unserviceable state to scrapped" do
    stock_item = stock_items(:unserviceable)
    assert stock_item.unserviceable?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "scrapped", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.scrapped?
  end

  test "stock item will not mutate from unserviceable state to any other invalid states" do
    stock_item = stock_items(:unserviceable)
    assert stock_item.unserviceable?
    invalid_states = (StockItem.states.values -  StockItem::UnserviceableState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end
  end

  test "stock item will mutate from removed state to inspecting" do
    stock_item = stock_items(:removed)
    assert stock_item.removed?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "inspecting", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.inspecting?
  end

  test "stock item will mutate from removed state to unserviceable" do
    stock_item = stock_items(:removed)
    assert stock_item.removed?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "unserviceable", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.unserviceable?
  end

  test "stock item will not mutate from removed state to any other invalid states" do
    stock_item = stock_items(:removed)
    assert stock_item.removed?
    invalid_states = (StockItem.states.values -  StockItem::RemovedState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end
  end

  test "stock item will mutate from installed state to removed" do
    stock_item = stock_items(:installed)
    assert stock_item.installed?
    assert_difference 'Transfer.count', 1 do
      post transfers_url, params: { transfer: { destination_state: "removed", stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
    end
    assert stock_item.reload.removed?
  end

  test "stock item will not mutate from installed state to any other invalid states" do
    stock_item = stock_items(:installed)
    assert stock_item.installed?
    invalid_states = (StockItem.states.values -  StockItem::InstalledState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end
  end
  
  test "stock item will not mutate from transiting state to any other invalid states" do
    stock_item = stock_items(:transiting)
    assert stock_item.transiting?
    invalid_states = (StockItem.states.values -  StockItem::TransitingState.new(stock_item).valid_destination_states.map(&:to_s)) - [stock_item.state]
    invalid_states.each do |t|
      post transfers_url, params: { transfer: { destination_state: t.to_s, stock_item_id: stock_item.id, destination_stock_location_id: @stock_location.id } }
      method_name = t.to_s + "?"
      assert_not stock_item.reload.send(method_name)
    end
  end

end
