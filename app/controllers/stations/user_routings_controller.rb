class Stations::UserRoutingsController < ApplicationController
  include StationScoped

  before_action :set_station
  
  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]
    @user = User.find_by_email(email)

    if @user
      flash[:notice] = "You can add this user to the station by updating their access controls here"
      redirect_to user_accesses_url(@user)
    else
      redirect_to new_user_path(email: email)
    end
  end

end
