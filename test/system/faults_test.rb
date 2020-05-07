require "application_system_test_case"

class FaultsTest < ApplicationSystemTestCase
  setup do
    @user = users(:chris)
    @activity = activities(:open_wp)
    @fault = faults(:fault_opened_in_wp)
    @discrepancy = discrepancies(:no_avod_at_seat)
    @fault_raised_at_selector = '#fault_raised_at'
    browser_sign_in_as @user
  end

  test "clicking on a value from discrepancy-catgeory dropdown should show discrepancy-name dropdown" do
    visit new_activity_fault_path(@activity)
    assert_selector "#fault_discrepancy_id", visible: :hidden
    select(@discrepancy.discrepancy_category.category, from: "fault[discrepancy_category]").select_option
    assert_selector "#fault_discrepancy_id", visible: :visible
  end

  test "discrepancy-name dropdown is hidden if no option is selected from category dropdown" do
    visit new_activity_fault_path(@activity)
    assert_selector "#fault_discrepancy_id", visible: :hidden
    first('#fault_discrepancy_category option').select_option
    assert_selector "#fault_discrepancy_id", visible: :hidden
  end

  test "select discrepancy name specific to particular discrepancy category" do
    visit new_activity_fault_path(@activity)
    assert_selector "#fault_discrepancy_id", visible: :hidden
    select(@discrepancy.discrepancy_category.category, from: "fault[discrepancy_category]").select_option
    assert_selector "#fault_discrepancy_id", visible: :visible
    assert all('#fault_discrepancy_id option').map(&:text).include? @discrepancy.name
  end

  test "new faults form should show discovered-in-flight fields" do
    visit new_activity_fault_path(@activity)
    assert_selector "div.confirmed", visible: :visible
    assert_selector "div.cid", visible: :visible
    assert_selector "div.inboundDeferred", visible: :visible
  end

  test "clicking dicovered-on-ground should only show cid and hide discovered-in-flight fields" do
    visit new_activity_fault_path(@activity)
    choose('fault_discovered_on_ground')

    assert_selector "div.confirmed", visible: :hidden
    assert_selector "div.actionCarried", visible: :hidden
    assert_selector "div.inboundDeferred", visible: :hidden
    assert_selector "div.deferralReference", visible: :hidden
    assert_selector "div.cid", visible: :visible
  end

  test "clicking discovered-in-flight should only show related fields with required html property" do
    visit new_activity_fault_path(@activity)
    choose('fault_discovered_on_ground')
    choose('fault_discovered_in_flight')

    assert_selector "div.confirmed", visible: :visible
    assert_selector "div.cid", visible: :visible
    assert_selector "div.inboundDeferred", visible: :visible
  end

  test "within discovered-in-flight and clicking failure-confirmed-yes should show cid and hide action-carried and vice-versa" do
    visit new_activity_fault_path(@activity)

    uncheck 'fault_confirmed'
    assert_selector "div.actionCarried", visible: :visible
    assert_selector "div.cid", visible: :hidden

    check 'fault_confirmed'
    assert_selector "div.actionCarried", visible: :hidden
    assert_selector "div.cid", visible: :visible
  end

  test "within discovered-in-flight and clicking inbound-deferred-yes should show deferral-reference and hide otherwise" do
    visit new_activity_fault_path(@activity)

    check 'fault_inbound_deferred'
    assert_selector "div.deferralReference", visible: :visible

    uncheck 'fault_inbound_deferred'
    assert_selector "div.deferralReference", visible: :hidden
  end

  test "create a fault inside activity" do
    visit activity_path(@activity)
    click_on("Add Logbook Item")

    find(@fault_raised_at_selector).click
    fill_in "fault[logbook_reference]", with: '123'
    choose('fault_discovered_on_ground')
    fill_in "fault[logbook_text]", with: 'abc'
    select(@discrepancy.discrepancy_category.category, from: "fault[discrepancy_category]").select_option
    select(@discrepancy.name, from: "fault[discrepancy_id]").select_option
    click_on("Create Fault")

    assert_selector(:css, '#fault_section', visible: :visible)
  end

  test "should edit fault if in originating activity" do
    visit activity_fault_path(@activity, @fault)

    click_on("Edit")
    find('[data-test-id="cid"]').set(true)
    click_on("Update Fault")

    assert_selector(:css, '#fault_section', visible: :visible)
  end

  test "should clone a fault" do
    visit activity_fault_path(@activity, @fault)

    find('a', text: 'Clone').click
    fill_in "fault[logbook_reference]", with: '123'
    click_on("Create Fault")

    assert_selector(:css, '#fault_section', visible: :visible)
  end

  test "should select seats via lopa on create" do
    visit activity_path(@activity)
    click_on("Add Logbook Item")

    find(@fault_raised_at_selector).click
    fill_in "fault[logbook_reference]", with: '123'
    choose('fault_discovered_on_ground')

    find(id: 'fault_seats_impacted').click
    find(id: '10J').click
    find(id: '1A').click
    find(id: '2E').click
    find(id: '3K').click
    find(id: '10K').click
    click_on("Add Selected Seats", match: :first)

    fill_in "fault[logbook_text]", with: 'abc'
    select(@discrepancy.discrepancy_category.category, from: "fault[discrepancy_category]").select_option
    select(@discrepancy.name, from: "fault[discrepancy_id]").select_option
    click_on("Create Fault")

    assert_selector(:css, '#fault_section', visible: :visible)
    assert_selector 'td', text: '1A, 2E, 3K, 10J, 10K'
  end

  test "should edit seats via lopa on edit" do
    visit activity_path(@activity)
    click_on("Add Logbook Item")

    find(@fault_raised_at_selector).click
    fill_in "fault[logbook_reference]", with: '123'
    choose('fault_discovered_on_ground')

    find(id: 'fault_seats_impacted').click
    find(id: '10J').click
    find(id: '1A').click
    click_on("Add Selected Seats", match: :first)

    fill_in "fault[logbook_text]", with: 'abc'
    select(@discrepancy.discrepancy_category.category, from: "fault[discrepancy_category]").select_option
    select(@discrepancy.name, from: "fault[discrepancy_id]").select_option
    click_on("Create Fault")

    assert_selector(:css, '#fault_section', visible: :visible)

    click_on("Edit")

    find(id: 'fault_seats_impacted').click
    find(id: '10J').click
    click_on("Add Selected Seats", match: :first)
    click_on("Update Fault")

    assert_selector(:css, '#fault_section', visible: :visible)
    assert_text 'Seats Impacted (1):'
  end

  test "clicking on raised-at shows datetimepicker widget" do
    visit new_activity_fault_path(@activity)
    assert_no_selector "div.bootstrap-datetimepicker-widget"

    find('#fault_raised_at').click
    assert_selector "div.bootstrap-datetimepicker-widget", visible: :visible
  end

end
