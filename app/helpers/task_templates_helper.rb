module TaskTemplatesHelper
  def repeat_interval(interval)
    if interval
      "Every #{pluralize interval, "Day" }"
    else
      "On Completion"
    end
  end
end
