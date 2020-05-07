class CommentsController < ApplicationController

  before_action :set_comment, except: [:create]

  def create
    @comment = @commentable.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: "Comment added successfully." }
        format.json { render json: @commentable.to_json(include: :comments), status: :created, location: @comment }
      else
        format.html { redirect_back fallback_location: root_path, notice: @comment.errors.full_messages }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if valid_author? && @comment.update(comment_params)
        format.html { redirect_to @comment.commentable, notice: 'Comment updated successfully.' }
        format.json { render json: @comment.commentable.to_json(include: :comments), status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if valid_author? && @comment.destroy
        format.html { redirect_back fallback_location: root_path, notice: 'Comment deleted successfully.' }
        format.json { head :no_content }
      else
        format.html { redirect_back fallback_location: root_path, notice: 'Operation unsuccessful. Comment can only be deleted by its author.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:description)
    end

    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end

    def valid_author?
      if @comment.try(:user) != Current.user
        @comment.errors.add(:user, "Only #{@comment.user.full_name} can perfrom this action")
        return false
      end
      return true
    end
end
