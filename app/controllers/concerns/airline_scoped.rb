module AirlineScoped
  extend ActiveSupport::Concern

  private
    def set_airline
      return if @airline = Current.user.airlines.find_by(id: param_id)
      redirect_to access_denial_path(id: Current.user, denied_resource_title: atempted_access_name)
    end

    def param_id
      params[:airline_id] || params[:id]
    end

    def atempted_access_name
      Airline.find_by(id: param_id).try(:name) || nil
    end
end
