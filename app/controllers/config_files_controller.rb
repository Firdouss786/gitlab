class ConfigFilesController < ApplicationController
  before_action :set_config_file

  def show
  end

  def destroy
    # First purge the uploaded file associated with record.
    @fleet_file.config_file_payload.purge

    # Delete all associated seats data.
    @fleet_file.fleet.seats.each do |seat|
      seat.destroy
    end

    # Delete ConfigFile data.
    @fleet_file.destroy
    Rails.cache.delete(@fleet_file.fleet)

    redirect_to fleet_path(@fleet_file.fleet)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config_file
      @fleet_file = ConfigFile.find(params[:id])
    end
end