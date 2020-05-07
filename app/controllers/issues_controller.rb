class IssuesController < ApplicationController
  include StationScoped, AirlineScoped
  include Redirectable

  before_action :set_fault, only: [:show, :edit, :update, :destroy, :approve]

  def index
    @faults = @airline.faults.pending_or_approved
    render "issues/airline/index"
  end

  def show
  end

  def new
    @fault = Fault::Issue.new
  end

  def edit
  end

  def create
    @fault = Fault::Issue.new(issue_params)
    @fault.requires_approval!

    respond_to do |format|
      if @fault.save
        format.html { redirect_to airline_issues_path(@airline), notice: 'Fault was successfully created.' }
        format.json { render :show, status: :created, location: @fault }
      else
        format.html { render :new }
        format.json { render json: @fault.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fault.update(issue_params)
        format.html { redirect_to redirection_path, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve
    @fault.approved!

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { render :show, status: :created }
    end
  end

  private
    def set_fault
      @fault = Fault.find(params[:id])
    end

    def issue_params
      params.require(:fault_issue).permit(:aircraft_id, :mcc_description, :seats_impacted)
    end
end
