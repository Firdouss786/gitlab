class TasksController < ApplicationController
  include ActivityScoped
  authorize_resource class: false

  layout "activity"

  before_action :set_activity
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @activity.tasks
  end

  def show
    @attachment = ConfigApplicability.find_by_task_template_id(@task.task_template).task_document
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = new_task(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to [@activity, @task] }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task.started_in_activity ||= @activity

    respond_to do |format|
      if is_allowed? && @task.update(task_params)
        format.html { redirect_to [@activity, @task] }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if is_allowed? && (@activity.created? || @activity.active?) && @task.task_actions.blank? && @task.destroy
        format.html { redirect_to @activity, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to [@activity, @task], notice: 'Operation unsuccessful. Cannot delete task if task actions are present and outside its originating activity or current activity is complete/error.' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def new_task(task_params)
      BuildTaskService.new({template: task_template, aircraft: @activity.aircraft, activity: @activity, options: task_params}).call
    end

    def task_params
      params.require(:task).permit(:started_at, :task_template_id, :logbook_reference, :logbook_text)
    end

    def task_template
      TaskTemplate.find task_params[:task_template_id]
    end

    def default_or_selected_airline(station)
      params["airline"].blank? ? station.default_program : station.airlines.find(params[:airline])
    end

    def is_allowed?
      if @task.started_in_activity.blank? || @task.started_in_activity == @activity
        true
      else
        @task.errors.add(:base, "cannot edit/delete task unless created within this activity.")
        false
      end
    end

end
