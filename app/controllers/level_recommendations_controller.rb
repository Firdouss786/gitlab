class LevelRecommendationsController < ApplicationController
  authorize_resource class: false
  before_action :set_level_recommendation, only: [:show, :edit, :update, :destroy]

  # GET /level_recommendations
  # GET /level_recommendations.json
  def index
    @level_recommendations = LevelRecommendation.all
  end

  # GET /level_recommendations/1
  # GET /level_recommendations/1.json
  def show
  end

  # GET /level_recommendations/new
  def new
    @level_recommendation = LevelRecommendation.new
  end

  # GET /level_recommendations/1/edit
  def edit
  end

  # POST /level_recommendations
  # POST /level_recommendations.json
  def create
    @level_recommendation = LevelRecommendation.new(level_recommendation_params)

    respond_to do |format|
      if @level_recommendation.save
        format.html { redirect_to @level_recommendation, notice: 'Level recommendation was successfully created.' }
        format.json { render :show, status: :created, location: @level_recommendation }
      else
        format.html { render :new }
        format.json { render json: @level_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /level_recommendations/1
  # PATCH/PUT /level_recommendations/1.json
  def update
    respond_to do |format|
      if @level_recommendation.update(level_recommendation_params)
        format.html { redirect_to @level_recommendation, notice: 'Level recommendation was successfully updated.' }
        format.json { render :show, status: :ok, location: @level_recommendation }
      else
        format.html { render :edit }
        format.json { render json: @level_recommendation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /level_recommendations/1
  # DELETE /level_recommendations/1.json
  def destroy
    @level_recommendation.destroy
    respond_to do |format|
      format.html { redirect_to level_recommendations_url, notice: 'Level recommendation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_level_recommendation
      @level_recommendation = LevelRecommendation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def level_recommendation_params
      params.require(:level_recommendation).permit(:product_id, :recommended_quantity, :stock_location_id)
    end
end
