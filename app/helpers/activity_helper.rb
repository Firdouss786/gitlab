module ActivityHelper

  def flight_status activity
    return "" unless activity.flight.present?
    activity.flight.status
  end

  def arrival_date activity
    return "" unless activity.flight.present?
    date activity.flight.estimated_arrival_time
  end

  def arrival_time activity
    return "" unless activity.flight.present?
    time activity.flight.estimated_arrival_time
  end

  def departure_date activity
    return "" unless activity.flight.present?
    return "" unless activity.flight.next_flight.present?

    date activity.flight.next_flight.filed_departure_time
  end

  def departure_time activity
    return "" unless activity.flight.present?
    return "" unless activity.flight.next_flight.present?

    time activity.flight.next_flight.filed_departure_time
  end

  def ground_time activity
    return "" unless activity.flight.present?
    return "" unless activity.flight.next_flight.present?

    json = activity.flight.ground_time

    "#{json[:hours].to_s.rjust(2, '0')}:#{json[:minutes].to_s.rjust(2, '0')}"
  end


end
