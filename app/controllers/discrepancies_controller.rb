class DiscrepanciesController < ApplicationController
  include Sortable
  authorize_resource class: false

  before_action :set_discrepancy, only: [:show, :edit, :update, :archival_status]
  before_action :set_category, only: [:index, :new, :create, :edit, :update]
  before_action :archival_status, only: [:update]

  def index
    @discrepancies = Discrepancy.where(discrepancy_category: @discrepancy_category).order(:name).search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    #@discrepancy_category = DiscrepancyCategory.find(params[:discrepancy_category_id])
    @discrepancy = @discrepancy_category.discrepancies.new
  end

  def edit
  end

  def create
    @discrepancy = @discrepancy_category.discrepancies.new(discrepancy_params)
    respond_to do |format|
      if @discrepancy.save
        format.html { redirect_to discrepancy_category_discrepancies_path(@discrepancy_category), notice: 'Discrepancy was successfully created.' }
        format.json { render :show, status: :created, location: @discrepancy }
      else
        format.html { render :new }
        format.json { render json: @discrepancy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @discrepancy.update(discrepancy_params)
        format.html { redirect_to discrepancy_category_discrepancies_path(@discrepancy_category), notice: 'Discrepancy was successfully updated.' }
        format.json { render :show, status: :ok, location: @discrepancy }
      else
        format.html { render :edit }
        format.json { render json: @discrepancy.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_discrepancy
      @discrepancy = Discrepancy.find(params[:id])
    end

    def set_category
      @discrepancy_category = DiscrepancyCategory.find(params[:discrepancy_category_id])
    end

    def discrepancy_params
      params.require(:discrepancy).permit(:name, :discrepancy_category_id)
    end

    def archival_status
      disable = params.dig(:discrepancy, :disable)
      if disable.present?
        @discrepancy.archive_by(Current.user) if disable == 'true'
        @discrepancy.restore if disable == 'false'
      end
    end

end
