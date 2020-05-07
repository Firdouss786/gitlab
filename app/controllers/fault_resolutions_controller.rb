class FaultResolutionsController < ApplicationController
  include ActivityScoped
  authorize_resource class: false
  layout "activity"

  before_action :set_activity
  before_action :set_fault

  def edit
  end

  def update
    respond_to do |format|
      if activity_is_active? && update_fault_state
        format.html { redirect_to [@activity, @fault.becomes(Fault)] }
        format.json { render :show, status: :ok, location: [@activity, @fault.becomes(Fault)] }
      else
        format.html { render :edit }
        format.json { render json: @fault.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_fault
      @fault = Fault::Logbook.find(params[:fault_id])
    end

    def resolving_action
      @resolving_action = @fault.corrective_actions.find(resolution_params[:resolving_corrective_action_id])
    end

    def resolution_params
      params.require(:fault_resolution).permit(:state, :resolving_corrective_action_id)
    end

    def activity_is_active?
      if @activity.complete? || @activity.error?
        @fault.errors.add(:base, "cannot update fault status, activity is in #{@activity.state} state.")
        false
      else
        true
      end
    end

    def update_fault_state
      if resolved?
        @fault.resolve resolving_action: resolving_action
      else
        @fault.reopen
      end
    end

    def resolved?
      ActiveModel::Type::Boolean.new.cast resolution_params[:state]
    end

end
