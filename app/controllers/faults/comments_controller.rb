class Faults::CommentsController < CommentsController
  before_action :set_commentable

  private
    def set_commentable
      @commentable = Fault.find(params[:fault_id])
    end

end
