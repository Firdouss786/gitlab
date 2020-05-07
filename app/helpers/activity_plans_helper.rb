module ActivityPlansHelper

  def activity_link(activity_plan)
    if activity_plan.try(:activity)
      activity_path(activity_plan.activity)
    else
      new_activity_path(aircraft_id: activity_plan.aircraft.id, station_id: activity_plan.station.id)
    end
  end

  def short_name(task)
    list = { 'level 1': 'L1', 'level 2': 'L2', 'level 3': 'L3' }
    name = task.name.downcase.to_sym
    list.key?(task.name) ? list[task.name] : task.name
  end

end
