class DeferralsController < ApplicationController

  include ActivityScoped

  layout "activity"

  before_action :set_fault, only: [:show, :new]
  before_action :set_deferral, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @deferral = CorrectiveAction.new
  end

  def edit
  end

  def create
    @deferral = CorrectiveAction.new(deferral_params)
    @deferral.activity = @activity
    @fault = @deferral.fault

    respond_to do |format|
      if @deferral.save
        format.html { redirect_to [@activity, @fault], notice: 'Deferral was successfully created.' }
        format.json { render :show, status: :created, location: @deferral }
      else
        format.html { render :new }
        format.json { render json: @deferral.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deferral.update(deferral_params)
        format.html { redirect_to [@activity, @deferral.fault], notice: 'Deferral was successfully updated.' }
        format.json { render :show, status: :ok, location: @deferral }
      else
        format.html { render :edit }
        format.json { render json: @deferral.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    fault = @deferral.fault
    respond_to do |format|
      if can_destroy? && @deferral.destroy
        format.html { redirect_to [@activity, fault], notice: 'Deferral was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to activity_deferral_path(@activity, @deferral, fault_id: fault.id), notice: "Deferral can only be destroyed within its originating activity and before workpack close." }
        format.json { render json: { error: "Deferral can only be destroyed within its originating activity and before workpack close.", status: :unprocessable_entity }, status: :unprocessable_entity }
      end
    end
  end

  def parts_required
    @parts = @activity.aircraft.bill_of_materials.order_by_part_number
    render partial: 'options_for_select', locals: {data: @parts, key: 'part_number', value: 'id', blank_label: '-- Select Part Number --'}
  end

  private
    def set_deferral
      @deferral = CorrectiveAction.find(params[:id])
    end

    def set_fault
      @fault = Fault.find(params[:fault_id])
    end

    # add in defer_class after migration
    def deferral_params
      params.require(:deferral).permit(:fault_id, :job_started_at, :performed_by_id, :maintenance_action_id, :logbook_text, :document_reference, :opdef, :defer_reason_id, :product_id)
    end

    def can_destroy?
      @deferral.activity == @activity && ['complete', 'error'].exclude?(@deferral.activity.state)
    end

end
