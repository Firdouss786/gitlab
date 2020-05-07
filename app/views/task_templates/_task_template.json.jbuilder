json.extract! task_template, :id, :name, :description, :applicable_content, :applicable_software, :applicability_type, :applicability_id, :repeat_interval, :state, :airline_id, :created_at, :updated_at
json.url task_template_url(task_template, format: :json)
