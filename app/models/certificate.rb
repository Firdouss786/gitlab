class Certificate < ApplicationRecord
  validates :reference, :governance, :stock_item, presence: true

  validates :governance, inclusion: { in: %w(FAA-21 EASA FAA CFC ESO CUSTOM CAAC GACA GCAA DOA CAAP CAAS DGCA DCA COFCONLY TCCA),
    message: "%{value} is not a valid certificate type" }

  belongs_to :stock_item

  def expire
    self.expired = true
    self.expired_at = DateTime.now
  end

  scope :valid, -> { where(expired: false) }
end
