class DeferralsQuery
  attr_reader :relation

  def initialize(relation = Deferral.all)
    @relation = relation
  end

  def active_on_aircraft(aircraft)
    @relation.active.where aircraft: aircraft
  end

  def raised_in_activity(activity)
    @relation.where activity: activity
  end

  def actioned_in_activity(activity)
    @relation.joins(:corrective_actions)
             .where(corrective_actions: { activity: activity })
  end

end
