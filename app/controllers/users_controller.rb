class UsersController < ApplicationController

  authorize_resource class: false

  before_action :set_user, only: [:edit, :update]

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to edit_user_path(@user), notice: "An email has been sent to #{@user.email} containing their login instructions." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :job_title, :manager_id, :locked, :active, :email, :secondary_email, :profile_id, :requires_verification, :home_station_id, :default_airline_id, :phone_number, :country_code)
    end
end
