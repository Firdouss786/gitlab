class TaskActionsUsersController < ApplicationController
  before_action :set_task_actions_user, only: [:show, :edit, :update, :destroy]

  # GET /task_actions_users
  # GET /task_actions_users.json
  def index
    @task_actions_users = TaskActionsUser.all
  end

  # GET /task_actions_users/1
  # GET /task_actions_users/1.json
  def show
  end

  # GET /task_actions_users/new
  def new
    @task_actions_user = TaskActionsUser.new
  end

  # GET /task_actions_users/1/edit
  def edit
  end

  # POST /task_actions_users
  # POST /task_actions_users.json
  def create
    @task_actions_user = TaskActionsUser.new(task_actions_user_params)

    respond_to do |format|
      if @task_actions_user.save
        format.html { redirect_to @task_actions_user, notice: 'Task actions user was successfully created.' }
        format.json { render :show, status: :created, location: @task_actions_user }
      else
        format.html { render :new }
        format.json { render json: @task_actions_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_actions_users/1
  # PATCH/PUT /task_actions_users/1.json
  def update
    respond_to do |format|
      if @task_actions_user.update(task_actions_user_params)
        format.html { redirect_to @task_actions_user, notice: 'Task actions user was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_actions_user }
      else
        format.html { render :edit }
        format.json { render json: @task_actions_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_actions_users/1
  # DELETE /task_actions_users/1.json
  def destroy
    @task_actions_user.destroy
    respond_to do |format|
      format.html { redirect_to task_actions_users_url, notice: 'Task actions user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_actions_user
      @task_actions_user = TaskActionsUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_actions_user_params
      params.require(:task_actions_user).permit(:task_action_id, :user_id)
    end
end
