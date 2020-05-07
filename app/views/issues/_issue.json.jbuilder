json.extract! issue, :id, :originator, :assignee, :state, :fault_id, :aircraft_id, :description, :seats_impacted, :severity, :source, :callback_url, :created_at, :updated_at
json.url issue_url(issue, format: :json)
