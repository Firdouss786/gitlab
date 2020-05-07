module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate, unless: :can_be_suppressed?

    def log_in(user)
      session[:user_id] = user.id
      authenticate
    end

    def log_out
      session[:user_id] = nil
      authenticate
    end
  end

  private

    def authenticate
      if authenticate_by_cookie || authenticate_by_token
        # Log In Successful
      else
        unauthorized!
      end
    end

    def authenticate_by_cookie
      if authenticated_user = User.find_by(id: session[:user_id])
        Current.user = authenticated_user
      end
    end

    def authenticate_by_token
      @user = authenticate_with_http_token { |token, options| User.find_by token: token}

        if @user && !@user.locked?
          Current.user = @user
        end
    end

    def unauthorized!
      if request.format == Mime[:json]
        head :unauthorized
      else
        session[:return_to] = params if request.fullpath != "/logout"
        redirect_to login_url
      end
    end

    def can_be_suppressed?
      in_development_mode? || path_should_not_be_authenticated?
    end

    def in_development_mode?
      if Rails.env.development?
        Current.user = User.find_by email: "chris.swann@thalesinflight.com"
      end
    end

    def path_should_not_be_authenticated?
      (request.path == "/login") || (request.path == "/verify") || (request.path.include? "/password_resets") || (request.path == "/flight_notifications")
    end
end
