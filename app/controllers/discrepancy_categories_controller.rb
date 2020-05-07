class DiscrepancyCategoriesController < ApplicationController
  include Sortable
  authorize_resource class: false

  before_action :set_discrepancy_category, only: [:show, :edit, :update, :destroy]

  def index
    @discrepancy_categories = DiscrepancyCategory.order(:category).search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @discrepancy_category = DiscrepancyCategory.new
  end

  def edit
  end

  def create
    @discrepancy_category = DiscrepancyCategory.new(discrepancy_category_params)

    respond_to do |format|
      if @discrepancy_category.save
        format.html { redirect_to discrepancy_categories_path, notice: 'Failure Mode was successfully created.' }
        format.json { render :show, status: :created, location: @discrepancy_category }
      else
        format.html { render :new }
        format.json { render json: @discrepancy_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @discrepancy_category.update(discrepancy_category_params)
        format.html { redirect_to discrepancy_categories_path, notice: 'Failure Mode was successfully updated.' }
        format.json { render :show, status: :ok, location: @discrepancy_category }
      else
        format.html { render :edit }
        format.json { render json: @discrepancy_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discrepancy_category.destroy if @discrepancy_category.discrepancies.empty?
    respond_to do |format|
      format.html { redirect_to discrepancy_categories_path, notice: 'Failure Mode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_discrepancy_category
      @discrepancy_category = DiscrepancyCategory.find(params[:id])
    end

    def discrepancy_category_params
      params.require(:discrepancy_category).permit(:category)
    end

end
