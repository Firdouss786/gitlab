module JumpLinksHelper
  def jump_to_station(name = nil, station = nil)
    if name && station
      content_tag :span, { class: "jump-menu__item" } do
        link_to name, build_path_for_station(station)
      end
    end
  end

  def jump_to_airline(name = nil, airline = nil)
    if name && airline
      content_tag :span, { class: "jump-menu__item" } do
        link_to name, build_path_for_airline(airline)
      end
    end
  end

  private
    def build_path_for_station(station)
      new_path = Rails.application.routes.recognize_path(request.path)
      new_path[:station_id] = station.id
      new_path
    end

    def build_path_for_airline(airline)
      new_path = Rails.application.routes.recognize_path(request.path)
      new_path[:airline_id] = airline.id
      new_path
    end
end
