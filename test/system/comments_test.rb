require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  # setup do
  #   @user = users(:chris)
  #   @activity = activities(:open_wp)
  #   @fault = faults(:fault_opened_in_wp)
  #   browser_sign_in_as @user
  # end
  #
  # test "clicking on add-comment-button shows comment form" do
  #   visit activity_fault_path(@activity, @fault)
  #   assert_selector "div.comments__form", visible: :hidden
  #
  #   click_on "+ ADD COMMENT"
  #   assert_selector "div.comments__form", visible: :visible
  # end
  #
  # test "clicking on comment-author-name should show author modal" do
  #   @fault = faults(:closed_fault)
  #   visit activity_fault_path(@activity, @fault)
  #   assert_selector "div.modal.contact-card.hidden", visible: :hidden
  #
  #   first(".text-link").click
  #   assert_selector "div.modal.contact-card.hidden", visible: :visible
  # end
  #
  # test "user can only see edit-delete for his comments" do
  #   visit activity_fault_path(@activity, @fault)
  #   assert_selector "div.i#{@user.id}", count: @fault.comments.where(user: @user).count, visible: :visible
  # end

end
