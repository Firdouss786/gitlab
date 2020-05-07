class TasksQuery
  attr_reader :relation

  def initialize(relation = Task.all)
    @relation = relation
  end

  def active_on_aircraft(aircraft)
    @relation.where(aircraft: aircraft).active
  end

  def raised_in_activity(activity)
    @relation.where started_in_activity: activity
  end

  def actioned_in_activity(activity)
    @relation.joins(:task_actions)
             .where(task_actions: { activity: activity })
  end

  def scheduled_tasks_for_aircraft(aircraft)
    @relation.where("aircraft_id = ? AND due_at <= ?", aircraft.id, Time.now).created
  end

end
