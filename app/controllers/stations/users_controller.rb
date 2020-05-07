class Stations::UsersController < ApplicationController
  include StationScoped, Sortable

  before_action :set_station

  # /stations/:station_id/users
  def index
    @users = @station.users.published.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page]).order(:id)
  end

  def archived
    @users = @station.users.archived.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page]).order(:id)
  end
end
