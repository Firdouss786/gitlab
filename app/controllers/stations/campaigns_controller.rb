class Stations::CampaignsController < ApplicationController
	include Sortable, StationScoped

	before_action :set_station, :get_user_airlines
	before_action :set_sortable_columns, :set_default_sort, only: [:index]

	def index
		@campaigns = Campaign.includes(task_template: :airline).where(task_templates: { airline: @airline_ids }).search(params[:q]).select(columns).references(:task_templates).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
	end

	def show
		@campaign = Campaign.joins(:task_template).find_by(id: params[:id], task_templates: { airline_id: @airline_ids })
		redirect_to access_denial_path(id: Current.user, denied_resource_title: attempted_access_name) unless @campaign
	end

	private

		def set_default_sort
      params[:sort] ||= "scheduled_start"
    end

		def set_sortable_columns
			@sortable_columns = ['id', 'name', 'icao_code','created_at', 'scheduled_start', 'scheduled_end']
		end

		def columns
      'campaigns.*, task_templates.name, airlines.icao_code'
	  end

		def get_user_airlines
			@airline_ids = Current.user.airlines.ids
		end

		def attempted_access_name
			Campaign.find_by(id: params[:id]).try(:task_template).try(:name)
		end

end
