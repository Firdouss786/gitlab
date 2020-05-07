class ActivityPlansController < ApplicationController

  include StationScoped

  def index
    @activity_plans = @station.activity_plans
  end

  def show
  end

  def create
  end

end
