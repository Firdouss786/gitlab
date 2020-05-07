module FleetScoped
  extend ActiveSupport::Concern

  private
    def set_fleet
      return if @fleet = Current.user.fleets.find_by(id: param_id)
      redirect_to access_denial_path(id: Current.user, denied_resource_title: atempted_access_name)
    end

    def param_id
      params[:fleet_id] || params[:id]
    end

    def atempted_access_name
      Fleet.find_by(id: param_id).try(:name) || nil
    end
end
