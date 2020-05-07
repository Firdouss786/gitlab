class Activity::ErrorState

	def validate
		true
	end

	def initialize(activity)
		@activity = activity
	end

	def faults
		Fault.where(activity: @activity).not_deferred
	end

	def deferrals
		deferrals =  DeferralsQuery.new.raised_in_activity(@activity)
		deferrals += DeferralsQuery.new.actioned_in_activity(@activity)
		deferrals.uniq
	end

	def tasks
		tasks =  TasksQuery.new.raised_in_activity(@activity)
		tasks += TasksQuery.new.actioned_in_activity(@activity)
		tasks.uniq
	end

	def scheduled_tasks
		Task.none
	end

	def enabled_for_state(function)
		[].include?(function)
	end

	def valid_destination_states
		[]
	end

end
