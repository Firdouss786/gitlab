class TaskActionsController < ApplicationController
  include ActivityScoped
  authorize_resource class: false

  layout "activity"

  before_action :set_activity
  before_action :set_task, only: [:new]
  before_action :set_task_action, only: [:show, :edit, :update, :destroy]

  # def index
  #   @task_actions = @task.task_actions
  # end

  def show
  end

  def new
    @task_action = TaskAction.new
  end

  def edit
  end

  def create
    @task_action = TaskAction.new(task_action_params)
    @task_action.activity = @activity
    @task = @task_action.task

    respond_to do |format|
      if @task_action.save
        format.html { redirect_to [@activity, @task_action.task] }
        format.json { render :show, status: :created, location: @task_action }
      else
        format.html { render :new }
        format.json { render json: @task_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if is_allowed? && @task_action.update(task_action_params)
        format.html { redirect_to [@activity, @task_action.task] }
        format.json { render :show, status: :ok, location: @task_action }
      else
        format.html { render :edit }
        format.json { render json: @task_action.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = @task_action.task
    respond_to do |format|
      if (@activity.created? || @activity.active?) && is_allowed? && @task_action.destroy
        format.html { redirect_to [@activity, @task] }
        format.json { head :no_content }
      else
        format.html { redirect_to [@activity, @task], notice: "Task Action can only be destroyed within its originating activity and before workpack close." }
        format.json { render json: { error: "Task Action can only be destroyed within its originating activity and before workpack close.", status: :unprocessable_entity }, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_task_action
      @task_action = TaskAction.find(params[:id])
    end

    def set_task
      @task = Task.find(params[:task_id])
    end

    def task_action_params
      params.require(:task_action).permit(:completed_at, :completion_percentage, :logbook_text, :task_id, user_ids: [])
    end

    def is_allowed?
      if @task_action.activity == @activity
        true
      else
        @task_action.errors.add(:base, "cannot edit task action outside its originating activity")
        false
      end
    end

end
