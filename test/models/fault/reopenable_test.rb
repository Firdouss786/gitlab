require 'test_helper'

class Fault::ReopenableTest < ActiveSupport::TestCase

	setup do
		@fault = faults(:fault_opened_in_wp)
		@ca = corrective_actions(:consumable_replacement_two)
  end

  test "should reopen fault" do
		assert @fault.active?
		@fault.resolve resolving_action: @ca

		assert @fault.closed?
		assert_equal @ca, @fault.resolving_corrective_action

 		@fault.reopen
		
 		assert @fault.active?
		assert_nil @fault.resolving_corrective_action
 	end

end
