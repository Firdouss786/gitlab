class TransferConstructor
  include ActiveModel::Model

  attr_accessor :stock_item, :state, :category, :comment, :sent_by, :received_by, :source_stock_location, :destination_stock_location, :sent_at,
  :received_at, :created_by, :from_state, :to_state

  # TODO: Validations
  # TODO: Testing

  def initialize(stock_item:, destination_state:, destination_stock_location:, user:)
    @stock_item = stock_item

    @state = "CLOSE"
    @category = "CREATION"
    @comment = nil
    @sent_by = user
    @received_by = user
    @source_stock_location = @stock_item.stock_location
    @destination_stock_location = destination_stock_location
    @sent_at = current_time
    @received_at = current_time
    @created_by = user
    @from_state = @stock_item.state
    @to_state = destination_state
  end

  def becomes(klass)
    became = klass.new
    became.assign_attributes(self.instance_values)
    became
  end

  private

    def current_time
      Time.now
    end

end
