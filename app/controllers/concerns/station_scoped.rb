module StationScoped
  extend ActiveSupport::Concern

  private
    def set_station
      return if @station = Current.user.stations.find_by(id: param_id)
      redirect_to access_denial_path(id: Current.user, denied_resource_title: atempted_access_name)
    end

    def param_id
      params[:station_id] || params[:id]
    end

    def atempted_access_name
      Station.find_by(id: param_id).try(:name) || nil
    end
end
