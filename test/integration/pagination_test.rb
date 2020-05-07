require 'test_helper'

class PaginationTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @airline = airlines(:baw)
  end

  # test "Should get correct number of results per page" do
  #   get "#{airline_faults_url(@airline)}.json?page=1"
  #   assert_equal 3, JSON.parse(response.body).count
  #
  #   get "#{airline_faults_url(@airline)}.json?page=3"
  #   assert_equal 3, JSON.parse(response.body).count
  # end
  #
  # test "Should get a link header for next page" do
  #   get "#{airline_faults_url(@airline)}.json?page=2"
  #
  #   link_hash = {:next=>"http://www.example.com/airlines/#{@airline.id}/faults.json?page=3; rel='next'"}
  #   assert_equal link_hash, response.header["Link"]
  # end
  #
  # test "Link header should be blank if it's the last page" do
  #   get "#{airline_faults_url(@airline)}.json?page=4"
  #
  #   assert_nil response.header["Link"]
  # end

end
