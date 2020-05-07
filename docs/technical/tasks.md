# Tasks
Task is a planned maintenance activity witha speciifc task card to accomplish. One or more tasks can be added to a work package and one or more technicians can record work performed through task actions on a particular task.

### Types of Tasks
There are two ways to create a Task, – a manual task creation and an automatic scheduling(its done in task templates).

### Manual Task Creation
Manual Task is created inside a work package, its initial state is set to `created` and completion percentage value is defaulted to `0` upon task creation.

**Task form values:**
- `user` will be set to `Current.user` if the logged in user has access to aircraft.
- `started_at` on web will be auto-filled to `Time.now`.
- `task_template_id` will have predefined set of task cards from which user can select specific task card to be performed.
- `logbook_reference` will have the reference number.
- `logbook_text` will have task related description.
- `activity` will get its value from route. 
- `aircraft` will get its value from its work pack`(@activity.aircraft)`.

#### States

 - Created: All task objects have an initial state of `created`.

 - Active: All task objects have a state of `active` once the task has been started and its not yet completed.

 - Completed: Once the task is 100% complete, its state will be changed to `completed`.


# Task Actions

**TaskAction form values:**
- `completed_at` on web will be auto-filled to `Time.now`.
- `performed_by` will have list of users from which one or more techinican who have worked on task can be selected.
- `completion_percentage` will have task's completion percentage(1-100) 
- `logbook_text` will have action description.

Completion percentage will also update the task's total completion percentage on the task model and task action users will be updated with task action id and respective user's id selected from taskAction form who has performed the task.
