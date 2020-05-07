module StatusIconsHelper

  def deferral_status?(fault, activity)
    fault.deferral_closed? || (fault.deferred? && fault.last_deferral.activity == activity)
  end

  def task_status?(task, activity)
    task.completed? || (task.active? && task.last_task_action.try(:activity) == activity)
  end

  def logbook_fault_status?(fault)
    !(fault.active?)
  end

end
