class Event < ApplicationRecord
  belongs_to :eventable, polymorphic: true
  belongs_to :stock_item

  after_create_commit do
    eventable.apply_actions! # Duck type
  end
end
