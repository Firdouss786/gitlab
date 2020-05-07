require 'test_helper'

class MaintenanceActionTest < ActiveSupport::TestCase

  setup do
    @maintenance_action = maintenance_actions(:reconnect)
  end

  test "cannot have duplicate name" do
    new_action = @maintenance_action.dup
    assert new_action.invalid?
    refute_empty new_action.errors[:name]
  end

end
