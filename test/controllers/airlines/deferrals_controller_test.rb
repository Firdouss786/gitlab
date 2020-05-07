require 'test_helper'

class Airlines::DeferralsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @airline = airlines(:baw)
    @deferral = faults(:fault_deferral)
    @csv_header = ["DAYS OPEN", "ID", "AIRLINE", "RAISED", "TAIL", "SEATS #", "SEATS", "REFERENCE", "DESCRIPTION"]
  end

  test "index" do
    get airline_deferrals_path(@airline)
    assert_response :success

    assert_select '.table .table-head', count: 1
    assert_select '.table a.table-body', count: 10
    assert_select  "a", text: "Export as CSV"
  end

  test "show" do
    get airline_deferral_path(@airline, @deferral)
    assert_response :success

    assert_select 'span', text: @deferral.logbook_text
  end

  test "returns a valid CSV file and data" do
    get airline_deferrals_path(@airline, format: :csv)
    assert_response :success
    assert_equal "text/csv", response.content_type  

    csv = CSV.parse response.body # Let raise if invalid CSV
    assert csv  
    assert_equal 11, csv.size
    assert(csv.first == @csv_header)
  end  
end
