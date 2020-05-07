require 'test_helper'

class ArchiveTest < ActiveSupport::TestCase
  setup { Current.user = users(:chris) }

  # test "Task Template can be archived" do
  #   template = task_templates(:content_load)
  #
  #   assert template.published?
  #   template.archive_by Current.user
  #   assert template.archived?
  # end
  #
  # test "Task Template can be restored" do
  #   template = task_templates(:archived)
  #
  #   assert template.archived?
  #   template.restore
  #   assert template.published?
  # end
  #
  # test "archiving a task template will archive its child tasks" do
  #   template = task_templates(:recurring_level_2)
  #
  #   template.archive_by Current.user
  #   assert template.tasks.first.archived?
  # end
  #
  # test "discrepancy can be archived" do
  #   discrepancy = discrepancies(:usb_plug)
  #
  #   assert discrepancy.published?
  #   discrepancy.archive_by Current.user
  #   assert discrepancy.archived?
  # end
  #
  # test "discrepancy can be restored" do
  #   discrepancy = discrepancies(:archived_discrepancy)
  #   assert discrepancy.archived?
  #   discrepancy.restore
  #   assert discrepancy.published?
  # end

  # TODO: Fixme
  # test "restoring a task template will restore its child tasks" do
  #   template = task_templates(:recurring_level_2)
  #   template.archive_by Current.user
  #   assert template.tasks.first.archived?
  #
  #   template.restore
  #   assert template.published?
  #   asset template.tasks.first.published?
  # end
end
