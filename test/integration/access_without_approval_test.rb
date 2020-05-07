require 'test_helper'

class AccessWithoutApprovalTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
  end

  test "requesting access to an Airline" do

    # John selects JBU airline. He should should gain imediate access (since he is an admin)
    sign_in_as users(:john)

    patch user_accesses_url(users(:john)), params: { user: { all_airline_ids: [airlines(:jbu).id, airlines(:baw).id], all_station_ids: [stations(:jfk).id] } }
    follow_redirect!
    assert_select ".pending-approvals__item", 0

    # Albert, the manager for JBU, wont see any messages
    sign_in_as users(:albert)
    get notifications_url
    assert_select ".pending-approvals__item", 0
  end

end
