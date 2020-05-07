module StockItem::Adjustable
  extend ActiveSupport::Concern

  included do
    # Adjustable can either be:
    # - CorrectiveAction
    # - LogisticsAction (Not Built Yet)
    def consume(quantity:, adjustable:)
      events.create eventable: Adjustment.new(quantity: -quantity, adjustable: adjustable)
    end

    def supply(quantity:, adjustable:)
      events.create eventable: Adjustment.new(quantity: +quantity, adjustable: adjustable)
    end
  end
end
