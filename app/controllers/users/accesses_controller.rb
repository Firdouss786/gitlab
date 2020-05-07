class Users::AccessesController < ApplicationController
  before_action :set_user, only: [:index, :update, :no_access]

  def index
    @airline_accesses = @user.accesses.where(accessible_type: "Airline")
    @station_accesses = @user.accesses.where(accessible_type: "Station")
  end

  def update
    authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_accesses_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to user_accesses_path(@user) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def user_params
      params.require(:user).permit(:default_airline_id, :home_station_id, all_airline_ids: [], all_station_ids: [] )
    end

end
