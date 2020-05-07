class RemovalReasonsController < ApplicationController
  authorize_resource class: false
  before_action :set_removal_reason, only: [:show, :edit, :update, :destroy]

  # GET /removal_reasons
  # GET /removal_reasons.json
  def index
    @removal_reasons = RemovalReason.all
  end

  # GET /removal_reasons/1
  # GET /removal_reasons/1.json
  def show
  end

  # GET /removal_reasons/new
  def new
    @removal_reason = RemovalReason.new
  end

  # GET /removal_reasons/1/edit
  def edit
  end

  # POST /removal_reasons
  # POST /removal_reasons.json
  def create
    @removal_reason = RemovalReason.new(removal_reason_params)

    respond_to do |format|
      if @removal_reason.save
        format.html { redirect_to @removal_reason, notice: 'Removal reason was successfully created.' }
        format.json { render :show, status: :created, location: @removal_reason }
      else
        format.html { render :new }
        format.json { render json: @removal_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /removal_reasons/1
  # PATCH/PUT /removal_reasons/1.json
  def update
    respond_to do |format|
      if @removal_reason.update(removal_reason_params)
        format.html { redirect_to @removal_reason, notice: 'Removal reason was successfully updated.' }
        format.json { render :show, status: :ok, location: @removal_reason }
      else
        format.html { render :edit }
        format.json { render json: @removal_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /removal_reasons/1
  # DELETE /removal_reasons/1.json
  def destroy
    @removal_reason.destroy
    respond_to do |format|
      format.html { redirect_to removal_reasons_url, notice: 'Removal reason was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_removal_reason
      @removal_reason = RemovalReason.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def removal_reason_params
      params.require(:removal_reason).permit(:name, :product_category_id, :description)
    end
end
