class Stations::CorrectiveActionsController < ApplicationController
  include StationScoped

  before_action :set_station
  before_action :set_corrective_action

  def show
  end

  private

    def set_corrective_action
      @corrective_action = CorrectiveAction.find(params[:id])
    end

end
