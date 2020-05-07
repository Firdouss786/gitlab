class TaskTemplatesController < ApplicationController
  include Sortable, AirlineScoped

  before_action :set_airline
  before_action :set_task_template, only: [:show, :edit, :update, :destroy]
  
  authorize_resource class: false

  def index
    @task_templates = @airline.task_templates.published.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @task_template = @airline.task_templates.new
    @task_template.build_campaign

    @airline.fleets.each do |config|
      @task_template.config_applicabilities.new fleet: config
    end
  end

  def edit
  end

  def create

    @task_template = @airline.task_templates.new(task_template_params)
    @task_template.save

    respond_to do |format|
      format.html { redirect_to airline_task_templates_path(@task_template.airline), notice: 'Task Template was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    respond_to do |format|
      if @task_template.update(task_template_params)
        format.html { redirect_to airline_tasks_path(@airline), notice: 'Task template was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_template }
      else
        format.html { render :edit }
        format.json { render json: @task_template.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task_template.destroy
    respond_to do |format|
      format.html { redirect_to task_templates_url, notice: 'Task template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task_template
      @task_template = @airline.task_templates.find(params[:id])
    end

    def task_template_params
      params.require(:task_template).permit(:name, :description, :repeat_interval, :mode, config_applicabilities_attributes: [:applicable_content, :applicable_software, :selected, :fleet_id, :task_document], campaign_attributes: [:selected, :scheduled_end])
    end
end
