class Activity::CreatedState

	def validate
		true
	end

	def initialize(activity)
		@activity = activity
	end

	def faults
		Fault.none
	end

	def deferrals
		DeferralsQuery.new.active_on_aircraft(@activity.aircraft)
	end

	def tasks
		Task.none
	end

	def scheduled_tasks
		TasksQuery.new.scheduled_tasks_for_aircraft(@activity.aircraft)
	end

	def enabled_for_state(function)
		[:can_open].include?(function)
	end

	def valid_destination_states
		[:active]
	end

end
