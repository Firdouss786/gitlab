class ActivityPlan < ApplicationRecord

  belongs_to :station
  belongs_to :aircraft
  belongs_to :flight, optional: true
  belongs_to :activity, optional: true

  enum state: { created: 'created', cancelled: 'cancelled' }

  def cancel!
    cancelled!
  end

end
