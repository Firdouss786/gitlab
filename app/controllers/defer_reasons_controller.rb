class DeferReasonsController < ApplicationController
  include Sortable

  authorize_resource class: false
  before_action :set_defer_reason, only: [:show, :edit, :update, :destroy]

  def index
    @defer_reasons = DeferReason.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @defer_reason = DeferReason.new
  end

  def edit
  end

  def create
    @defer_reason = DeferReason.new(defer_reason_params)

    respond_to do |format|
      if @defer_reason.save
        format.html { redirect_to defer_reasons_url, notice: 'Defer reason was successfully created.' }
        format.json { render :show, status: :created, location: @defer_reason }
      else
        format.html { render :new }
        format.json { render json: @defer_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @defer_reason.update(defer_reason_params)
        format.html { redirect_to defer_reasons_url, notice: 'Defer reason was successfully updated.' }
        format.json { render :show, status: :ok, location: @defer_reason }
      else
        format.html { render :edit }
        format.json { render json: @defer_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @defer_reason.destroy
    respond_to do |format|
      format.html { redirect_to defer_reasons_url, notice: 'Defer reason was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_defer_reason
      @defer_reason = DeferReason.find(params[:id])
    end

    def defer_reason_params
      params.require(:defer_reason).permit(:name, :description)
    end
end
