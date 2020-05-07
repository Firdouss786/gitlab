class SearchController < ApplicationController

  def index
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @results = @search.perform
        format.html { render :index }
      else
        format.html { render :index }
      end
    end
  end

  private
    def search_params
      params.require(:search).permit(:text)
    end
end
