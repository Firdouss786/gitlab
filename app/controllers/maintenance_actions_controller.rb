class MaintenanceActionsController < ApplicationController

  include Sortable
  authorize_resource class: false

  before_action :set_maintenance_action, only: [:show, :edit, :update, :destroy]

  def index
    @maintenance_actions = MaintenanceAction.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @maintenance_action = MaintenanceAction.new
  end

  def edit
  end

  def create
    @maintenance_action = MaintenanceAction.new(maintenance_action_params)

    respond_to do |format|
      if @maintenance_action.save
        format.html { redirect_to maintenance_actions_path, notice: 'Maintenance action was successfully created.' }
        format.json { render :show, status: :created, location: @maintenance_action }
      else
        format.html { render :new }
        format.json { render json: @maintenance_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @maintenance_action.update(maintenance_action_params)
        format.html { redirect_to maintenance_actions_path, notice: 'Maintenance action was successfully updated.' }
        format.json { render :show, status: :ok, location: @maintenance_action }
      else
        format.html { render :edit }
        format.json { render json: @maintenance_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @maintenance_action.destroy
  #   respond_to do |format|
  #     format.html { redirect_to maintenance_actions_url, notice: 'Maintenance action was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_maintenance_action
      @maintenance_action = MaintenanceAction.find(params[:id])
    end

    def maintenance_action_params
      params.require(:maintenance_action).permit(:name, :description)
    end
end
