class NotificationsController < ApplicationController

  def index
    @user = Current.user
  end

end
