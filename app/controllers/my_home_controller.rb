class MyHomeController < ApplicationController

  authorize_resource class: false

  def index
    if Current.user.home_station
      redirect_to station_activities_path(Current.user.home_station)
    else
      redirect_to docks_path
    end
  end
end
