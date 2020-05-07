require 'test_helper'

class AccessWithApprovalTest < ActionDispatch::IntegrationTest
  setup do
    @test = true
  end

  # Disabled this feature as it needs more thorough QA testing - Chris Dec 17 2019
  # test "requesting access to an Airline" do
  #
  #   # Kathrine selects JBU airline. She should see the message on her screen, but see nothing in her notification center
  #   sign_in_as users(:kathrine)
  #
  #   patch user_accesses_url(users(:kathrine)), params: { user: {all_airline_ids: [airlines(:jbu).id, airlines(:baw).id], all_station_ids: [stations(:lax).id] } }
  #   follow_redirect!
  #   assert_select ".pending-approvals__item", "Katherine Goble has requested access to Jet Blue. This request was sent to albert@thalesinflight.com"
  #
  #   get notifications_url
  #   assert_select ".pending-approvals__item", 0
  #
  #   # Albert, the manager for JBU, will see a message in his notification center, his access page should not have any requests
  #   sign_in_as users(:albert)
  #   get notifications_url
  #   assert_select ".pending-approvals__item", "Katherine Goble requests access to Jet Blue"
  #
  #   get user_accesses_url(users(:albert))
  #   assert_select ".pending-approvals__item", 0
  # end


end
