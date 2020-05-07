module FlightsHelper
  # def humanize_flight_status status
  # 	status.in_air? ? "In Flight" : "On ground"
  # end

  def time_diff_to_time(json)
    return "" unless json
    "#{json[:hours].to_s.rjust(2, '0')}:#{json[:minutes].to_s.rjust(2, '0')}"
  end
end
