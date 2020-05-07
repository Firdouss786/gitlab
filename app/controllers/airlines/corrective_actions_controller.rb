class Airlines::CorrectiveActionsController < ApplicationController
  include AirlineScoped

  before_action :set_airline
  before_action :set_corrective_action

  def show
  end

  private

    def set_corrective_action
      @corrective_action = CorrectiveAction.find(params[:id])
    end

end
