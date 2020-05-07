require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  # setup do
  #   @user = users(:chris)
  #   @fault = faults(:closed_fault)
  #   @new_comment_description = "New comment for controller test"
  #   @user_comment = comments(:comment_by_chris)
  #   sign_in_as @user
  # end
  #
  # test "user can add comment" do
  #   assert_difference 'Comment.count' do
  #     assert post fault_comments_path(@fault), params: { comment: { description: @new_comment_description } }
  #     assert_redirected_to @fault
  #
  #     assert get fault_path(@fault)
  #     assert_select '.comment__description', text: @new_comment_description
  #   end
  # end
  #
  # test "user can edit his own comment" do
  #   assert_no_difference 'Comment.count' do
  #     assert patch comment_path(@user_comment), params: { comment: { description: @new_comment_description } }
  #     assert_redirected_to @fault
  #
  #     assert get fault_path(@fault)
  #     assert_select '.comment__description', text: @new_comment_description
  #   end
  # end
  #
  # test "user can delete his own comments" do
  #   assert_difference 'Comment.count', -1 do
  #     assert delete comment_path(@user_comment)
  #     assert_response :redirect
  #
  #     assert get fault_path(@fault)
  #     assert_select '.comment__description', text: @new_comment_description, count: 0
  #   end
  # end
  #
  # # API TESTS
  #
  # test "API should create new comment" do
  #   assert_difference '@fault.comments.count' do
  #     post fault_comments_path @fault, params: { comment: { description: @new_comment_description } }, format: :json
  #     assert_response 201, :created
  #     assert_equal @fault.comments.last.description, @new_comment_description
  #   end
  # end
  #
  # test "API should update a comment" do
  #   assert_no_difference 'Comment.count' do
  #     patch comment_path @user_comment, params: { comment: { description: @new_comment_description } }, format: :json
  #     assert_response :success
  #     assert_equal Comment.find(@user_comment.id).description, @new_comment_description
  #   end
  # end
  #
  # test "API should delete a comment" do
  #   assert_difference 'Comment.count', -1 do
  #     delete comment_path @user_comment, format: :json
  #     assert_response 204, :no_content
  #   end
  # end

end
