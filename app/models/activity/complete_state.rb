class Activity::CompleteState < Activity

	def validate
		boarding_time_should_be_set
		deplaning_time_should_be_set
		all_work_should_be_addressed
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

	private

		def boarding_time_should_be_set

		end

		def deplaning_time_should_be_set

		end

		def all_work_should_be_addressed

		end
end
