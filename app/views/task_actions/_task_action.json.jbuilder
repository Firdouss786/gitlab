json.extract! task_action, :id, :created_by_id, :completed_at, :completion_percentage, :logbook_text, :activity_id, :task_id, :user_id, :created_at, :updated_at
json.url task_action_url(task_action, format: :json)
