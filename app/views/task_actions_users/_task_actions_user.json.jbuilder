json.extract! task_actions_user, :id, :task_action_id, :user_id, :created_at, :updated_at
json.url task_actions_user_url(task_actions_user, format: :json)
