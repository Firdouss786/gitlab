class DeferralActionsController < ApplicationController
  include ActivityScoped
  authorize_resource class: false

  layout "activity"

  before_action :set_activity
  before_action :set_fault
  before_action :set_deferral_action, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @deferral_action = DeferralAction.new
  end

  def edit
  end

  def create
    @deferral_action = DeferralAction.new(deferral_params.merge(activity_id: @activity.id, fault_id: @fault.id))

    respond_to do |format|
      if @deferral_action.save
        format.html { redirect_to [@activity, @fault], notice: 'Deferral was successfully created.' }
        format.json { render :show, status: :created, location: @deferral_action }
      else
        format.html { render :new }
        format.json { render json: @deferral_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deferral_action.update(deferral_params)
        format.html { redirect_to [@activity, @deferral_action.fault], notice: 'Deferral was successfully updated.' }
        format.json { render :show, status: :ok, location: @deferral_action }
      else
        format.html { render :edit }
        format.json { render json: @deferral_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @deferral_action.destroy
        format.html { redirect_to [@activity, @fault], notice: 'Deferral was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to activity_fault_deferral_action_path(@activity, @fault, @deferral_action), notice: "Deferral can only be destroyed within its originating activity and before workpack close." }
        format.json { render json: { error: "Deferral can only be destroyed within its originating activity and before workpack close.", status: :unprocessable_entity }, status: :unprocessable_entity }
      end
    end
  end

  def parts_required
    @parts = @activity.aircraft.bill_of_materials.order_by_part_number
    render partial: 'options_for_select', locals: {data: @parts, key: 'part_number', value: 'id', blank_label: '-- Select Part Number --'}
  end

  private
    def set_deferral_action
      @deferral_action = DeferralAction.find(params[:id])
    end

    def set_fault
      @fault = Fault.find(params[:fault_id])
    end

    def deferral_params
      params.require(:deferral_action).permit(:fault_id, :job_started_at, :performed_by_id, :maintenance_action_id, :logbook_text, :document_reference, :opdef, :defer_reason_id, :product_id, :mel_category)
    end

end
