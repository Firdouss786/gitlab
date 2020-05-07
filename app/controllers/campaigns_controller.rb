class CampaignsController < ApplicationController
include AirlineScoped, Sortable

before_action :set_airline

  def show
    @task_template = Campaign.find(params[:id]).task_template
  end
end
