class FaultsController < ApplicationController
  include ActivityScoped
  authorize_resource class: false

  layout "activity"

  before_action :set_activity
  before_action :set_fault, only: [:show, :edit, :update, :destroy]


  def index
  end

  def show
  end

  def new
    @fault = Fault::Logbook.new
  end

  def clone
    @fault = Fault::Logbook.find(params[:id]).dup
    render :new
  end

  def edit
  end

  def create
    @fault = Fault::Logbook.new(fault_params)
    @fault.activity = @activity
    @fault.aircraft = @activity.aircraft

    respond_to do |format|
      if @fault.save
        format.html { redirect_to [@activity, @fault.becomes(Fault)] }
        format.json { render :show, status: :created, location: [@activity, @fault.becomes(Fault)] }
      else
        format.html { render :new }
        format.json { render json: @fault.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if can_update? && @fault.update(fault_params)
        format.html { redirect_to activity_fault_path(@activity, @fault) }
        format.json { render :show, status: :ok, location: activity_fault_path(@activity, @fault) }
      else
        format.html { render :edit }
        format.json { render json: @fault.errors, status: :unprocessable_entity }
      end
    end
  end

  # add validations after finalizing destory/error functionality.
  # validations will be tricky for Open/Closed workpack.
  def destroy
    @fault.mark_as_erroneous
    respond_to do |format|
      format.html { redirect_to @activity, notice: 'Fault was marked as an error' }
      format.json { head :no_content }
    end
  end

  def discrepancy_names
    @discrepancies = DiscrepancyCategory.find(params[:discrepancy_category]).discrepancies.published.order(:name)
    render partial: 'options_for_select', locals: {data: @discrepancies, key: 'name', value: 'id', blank_label: '-- Select Discrepancy Item --'}
  end

  private
    def set_fault
      @fault = Fault::Logbook.find(params[:id])
    end

    def fault_params
      params.require(:fault).permit(:raised_at, :recorded_by_id, :logbook_reference, :seats_impacted, :logbook_text, :discrepancy_id, :discovered, :confirmed, :inbound_deferred, :cid, :action_carried, :deferral_reference)
    end

    def can_update?
      if @fault.activity == @activity
        true
      else
        @fault.errors.add(:base, "cannot edit fault outside its originating activity.")
        false
      end
    end

end
