class SoftwarePlatformsController < ApplicationController
  include Sortable

  authorize_resource class: false
  before_action :set_software_platform, only: [:show, :edit, :update, :destroy]

  def index
    @software_platforms = SoftwarePlatform.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @software_platform = SoftwarePlatform.new
  end

  def edit
  end

  def create
    @software_platform = SoftwarePlatform.new(software_platform_params)

    respond_to do |format|
      if @software_platform.save
        format.html { redirect_to software_platforms_url, notice: 'Software platform was successfully created.' }
        format.json { render :show, status: :created, location: @software_platform }
      else
        format.html { render :new }
        format.json { render json: @software_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @software_platform.update(software_platform_params)
        format.html { redirect_to software_platforms_url, notice: 'Software platform was successfully updated.' }
        format.json { render :show, status: :ok, location: @software_platform }
      else
        format.html { render :edit }
        format.json { render json: @software_platform.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @software_platform.destroy
    respond_to do |format|
      format.html { redirect_to software_platforms_url, notice: 'Software platform was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_software_platform
      @software_platform = SoftwarePlatform.find(params[:id])
    end

    def software_platform_params
      params.require(:software_platform).permit(:name, :description)
    end
end
