class Fleet < ApplicationRecord

  include Searchable

  belongs_to :software_platform
  belongs_to :airline, touch: true
  belongs_to :aircraft_type

  has_many :product_allotments
  has_many :products, through: :product_allotments

  has_many :aircrafts
  has_many :config_applicabilities
  has_many :task_templates, through: :config_applicabilities
  has_many :seats
  has_one :config_file

  validates :name, :install_type, presence: true

  def searchable_attributes
    [name]
  end

end
