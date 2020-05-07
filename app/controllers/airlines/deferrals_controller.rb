class Airlines::DeferralsController < ApplicationController
  include Sortable, AirlineScoped, GenerateCsv

  before_action :set_sortable_columns, :set_default_sort, only: [:index]
  before_action :set_airline

  def index
    @deferrals = @airline.faults.deferred.search(params[:q]).includes(aircraft: [:airline]).select(columns).references(:aircrafts, :airlines).reorder(sort_pattern)
    render partial: 'deferrals/index', locals: { deferrals: @deferrals, parent: @airline } if refresh_request?

    respond_to do |format|
      format.html
      format.csv { send_data to_csv(index_csv_query, index_csv_header), filename: "airline_deferrals-#{Date.today}.csv", type: "text/csv", disposition: :attachment }
    end

  end

  def show
    @deferral = Fault.find(params[:id])
  end

  private

    def refresh_request?
      params[:refresh] == 'true'
    end

    def set_sortable_columns
      @sortable_columns = ['id', 'raised_at', 'impacted_seat_count', 'logbook_reference', 'tail', 'icao_code']
    end

    def set_default_sort
      params[:sort] ||= "raised_at"
    end

    def columns
      'faults.*, aircrafts.tail, airlines.icao_code'
    end

    def index_csv_header
      ['DAYS OPEN', 'ID', 'AIRLINE', 'RAISED', 'TAIL', 'SEATS #', 'SEATS', 'REFERENCE', 'DESCRIPTION']
    end

    def index_csv_query
       @deferrals.pluck(Arel.sql('DATEDIFF(CURDATE(), Date(faults.raised_at))'), 'faults.id', 'airlines.icao_code', 'Date(faults.raised_at)', 'aircrafts.tail', 'faults.impacted_seat_count', 'faults.seats_impacted', 'faults.logbook_reference', 'faults.logbook_text')
    end

end
