class ConfigFile < ApplicationRecord
  belongs_to :fleet
  belongs_to :user
  has_one_attached :config_file_payload

  enum file_type: { seatdat: 'seatdat', template: 'template' }
end
