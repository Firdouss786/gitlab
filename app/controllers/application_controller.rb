class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery unless: -> { request.format.json? }

  # Authorize all controller actions using CanCanCan gem
  # authorize_resource class: false

  rescue_from ActionController::InvalidAuthenticityToken do
    Rails.logger.error "Rescue from InvalidAuthenticityToken, redirecting to login_url"
    redirect_to login_url
  end

  # Load CanCanCan Ability Class
  def current_ability
    @current_ability ||= Ability.new(Current.user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_back fallback_location: root_path, notice: exception.message }
    end
  end

end
