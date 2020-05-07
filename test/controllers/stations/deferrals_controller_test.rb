require 'test_helper'

class Stations::DeferralsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @station = stations(:lhr)
    @deferral = faults(:fault_deferral)
    @csv_header = ["DAYS OPEN", "ID", "AIRLINE", "RAISED", "TAIL", "SEATS #", "SEATS", "REFERENCE", "DESCRIPTION"]
  end

  test "index" do
    get station_deferrals_path(@station)
    assert_response :success

    assert_select '.table .table-head', count: 1
    assert_select '.table a.table-body', count: 11
    assert_select  "a", text: "Export as CSV"
  end

  test "show" do
    get station_deferral_path(@station, @deferral)
    assert_response :success

    assert_select 'span', text: @deferral.logbook_text
  end

  test "returns a valid CSV file and data" do
    get station_deferrals_path(@station, format: :csv)
    assert_response :success
    assert_equal "text/csv", response.content_type  

    csv = CSV.parse response.body # Let raise if invalid CSV
    assert csv  
        
    assert_equal 12, csv.size
    assert(csv.first == @csv_header)
  end  
end
