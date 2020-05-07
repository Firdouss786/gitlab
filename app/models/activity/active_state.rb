class Activity::ActiveState

	def validate
		performing_technician_should_have_access_to_station
	end

	def initialize(activity)
		@activity = activity
	end

	def faults
		Fault.where(activity: @activity).not_deferred
	end

	def deferrals
		deferrals =  DeferralsQuery.new.active_on_aircraft(@activity.aircraft)
		deferrals += DeferralsQuery.new.raised_in_activity(@activity)
		deferrals += DeferralsQuery.new.actioned_in_activity(@activity)
		deferrals.uniq
	end

	def tasks
		tasks  = TasksQuery.new.active_on_aircraft(@activity.aircraft)
		tasks += TasksQuery.new.raised_in_activity(@activity)
		tasks += TasksQuery.new.actioned_in_activity(@activity)
		tasks.uniq
	end

	def scheduled_tasks
		TasksQuery.new.scheduled_tasks_for_aircraft(@activity.aircraft)
	end

	def enabled_for_state(function)
		[:can_close, :editable].include?(function)
	end

	def valid_destination_states
		[:complete]
	end

	private

		def performing_technician_should_have_access_to_station
			# @activity.errors[:base] << "Performing technician does not have acccess to this station"
			true
		end

end
