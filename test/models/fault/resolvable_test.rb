require 'test_helper'

class Fault::ResolvableTest < ActiveSupport::TestCase

	setup do
		@fault = faults(:fault_opened_in_wp)
		@ca = corrective_actions(:consumable_replacement_two)
  end

  test "should resolve fault" do
		assert @fault.active?

		@fault.resolve resolving_action: @ca

		assert @fault.closed?
		assert_equal @ca, @fault.resolving_corrective_action
	end

end
