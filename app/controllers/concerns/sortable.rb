module Sortable
  extend ActiveSupport::Concern

  included do
    helper_method :sort_column, :sort_direction
  end

  private

    def sort_column
      @sortable_columns ||= controller_name.classify.constantize.column_names
      @sortable_columns.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_pattern
      sort_column + ' ' + sort_direction
    end

end
