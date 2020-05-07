class Program < ApplicationRecord
  validates :mcc_email, :repair_order_note, presence: true

  belongs_to :airline
  belongs_to :airport

  has_and_belongs_to_many :stations
end
