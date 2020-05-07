class SignOffsController < ApplicationController

  include ActivityScoped

  authorize_resource class: false

  def show
    # work on this and its view if needed
  end

  def new
    @sign_off = SignOff.new(activity: @activity)
  end

  def create
    @sign_off = SignOff.new(sign_off_params)
    @sign_off.boarded_at ||= @activity.boarded_at
    @sign_off.activity = @activity

    respond_to do |format|
      if @sign_off.process
        format.html { redirect_to @activity, notice: 'Sign off was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @sign_off.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def sign_off_params
      params.require(:activity).permit(:boarded_at, :unboarded_at)
    end

end
