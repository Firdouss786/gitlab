module DatesHelper

  def utc(date)
    date.strftime("%Y-%m-%dT%I:%M:%SZ") if date
  end

  def date(date)
    if date
      date.strftime("%d-%b-%Y")
    else
      ""
    end
  end

  def ISOdate(date)
    if date
      date.strftime("%F")
    else
      ""
    end
  end

  def shortdate(date)
    if date
      date.strftime("%d %b")
    else
      ""
    end
  end

  def datetime(date)
    if date
      date.strftime("%d-%b %H:%M")
    else
      ""
    end
  end

  def time(date)
    if date
      date.strftime("%H:%M")
    else
      ""
    end
  end

  def due(date)
    due_date = date.strftime("%d %b")
    "Due #{due_date}"
  end

  # Get durartion for the provided dates(from and to) and return hours or minutes or custom text
  def get_duration(from, to, rtn)
      duration = to - from

      hours = (duration / 3600).floor
      restDuration = duration%3600
      minutes = (restDuration / 60).floor

      if rtn == "text"
        if hours > 0
          return "#{hours.to_s.rjust(2,'0')}h #{minutes.to_s.rjust(2,'0')}m"
        else
          return "#{minutes.to_s.rjust(2,'0')} minutes"
        end
      elsif rtn == "hours"
        return hours
      elsif rtn == "mins"
        return minutes
      end
  end

  # Prepare Arrival text
  # If duration is more than one hour then return time in 24 hour format
  # If duration is less then one hour then return time in remaining minutes
  def station_arr_time(date)
    if date
      if get_duration(Time.now, date, "hours") > 0
        " at " + time(date)
      else
        return " in #{get_duration(Time.now, date, 'mins').to_s.rjust(2,'0')} minutes"
      end
    else
      ""
    end
  end

  # Prepare ground time text
  # Return in minutes if duration is less than an hour otherwise xx h and xx m format
  def station_ground_time(from, to)
      get_duration(from, to, "text")
  end

  # Prepare departure time text
  # If Departure date is today then display "time today" text
  # If Departure date is tomorrow then display "time tomorrow" text
  # If Departure date is in future from day after tomorrow then display "time date" text
  def station_dep_time(date)
    if date
      if date.strftime("%d").to_i == Time.now.strftime("%d").to_i
        time(date) + " today"
      elsif date.strftime("%d").to_i == (Time.now.strftime("%d").to_i + 1)
        time(date) + " tomorrow"
      else
        time(date) + " " + ISOdate(date)
      end
    else
      ""
    end
  end

end
