class StockItem::RemovedState

  def validate
	end

  def initialize(stock_item)
		@stock_item = stock_item
	end

  def valid_destination_states
		[:inspecting, :unserviceable]
	end

end
