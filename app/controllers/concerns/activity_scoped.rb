module ActivityScoped
  extend ActiveSupport::Concern

  private
    def set_activity
      # Need to scope this to airline also, but this requires an airline column on the acitivty table
      return if @activity = Activity.where(station: Current.user.stations).find_by(id: param_id)
      redirect_to access_denial_path(id: Current.user, denied_resource_title: atempted_access_name)
    end

    def param_id
      params[:activity_id] || params[:id]
    end

    def atempted_access_name
      nil
    end

end
