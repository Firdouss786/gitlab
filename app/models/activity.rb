class Activity < ApplicationRecord
  include Activity::Expireable, Searchable

  belongs_to :station
  belongs_to :aircraft

  belongs_to :flight, optional: true
  belongs_to :inbound_airport, optional: true
  belongs_to :outbound_airport, optional: true

  enum state: { created: 'created'.upcase, active: 'active'.upcase, complete: 'complete'.upcase, error: 'error'.upcase }

  validate { @current_state.validate }

  scope :arriving, -> { includes(:flight).select { |a| a.flight.try(:enroute?) }}
  scope :landed, -> { includes(:flight).select { |a| a.flight.try(:arrived?) }}

  attr_accessor :current_state

  after_initialize :set_state_class

  def set_state_class
    @current_state = "Activity::#{state.humanize}State".constantize.new(self)
  end

  def self.eligible_for_work
    where state: [:created, :active]
  end

  def faults
    @current_state.faults
  end

  def deferrals
    @current_state.deferrals
  end

  def tasks
    @current_state.tasks
  end

  def scheduled_tasks
    @current_state.scheduled_tasks
  end

  def enabled_for_state(function)
    @current_state.enabled_for_state(function)
  end

  def transition_to_state(state)
    if @current_state.valid_destination_states.include? state
      self.state = state
      set_state_class
      self.save
    else
      self.errors[:state] << "cannot switch to #{state}"
      false
    end
  end

  def searchable_attributes
    [self.aircraft.name]
  end

end
