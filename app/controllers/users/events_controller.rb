class Users::EventsController < ApplicationController
  before_action :set_user, only: [:index]

  # GET /users/:user_id/events
  def index
    @events = RedisLogger::Query.new(klass: "User", document_id: @user.id).perform
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end
end
