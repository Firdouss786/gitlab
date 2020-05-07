class ApprovalsController < ApplicationController
  before_action :set_approval, only: [:show, :edit, :update, :destroy]

  def update
    @approval.approved!
    redirect_to :notifications
  end

  def destroy
    @approval.destroy
    redirect_to :notifications
  end

  private
    def set_approval
      @approval = Approval.find(params[:id])
    end
end
