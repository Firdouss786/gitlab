class Aircraft < ApplicationRecord
  include FlightSubscribable, Searchable

  before_validation :set_airline

  validates :tail, :msn, :registration, presence: true

  belongs_to :fleet, touch: true
  belongs_to :airline, touch: true

  has_one :stock_location, as: :parent
  has_one :aircraft_status, class_name: "Aircraft::Status"
  has_many :tasks
  has_many :flights
  has_many :faults
  has_many :activities

  after_save_commit do
    activities.eligible_for_work.touch_all
  end

  def searchable_attributes
    [tail, msn, fin, registration, description]
  end

  def bill_of_materials
    fleet.products
  end

  def name
    self.tail
  end

  def reg_and_nose
    if tail != registration
      "#{registration} (#{tail})"
    else
      registration
    end
  end

  def sanitized_for_api
    tail = self.registration || self.tail
    tail.gsub("-", "").downcase
  end

  def recurring_for(template_id)
    self.tasks.eligible_for_work.where(task_template_id: template_id).last
  end

  def campaign_for(template_id)
    self.tasks.where(task_template_id: template_id).first
  end

  def set_airline
    self.airline = self.fleet.airline
  end

end
