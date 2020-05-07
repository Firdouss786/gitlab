json.extract! user, :id, :airport_id, :home_station_id, :first_name, :last_name, :job_title, :manager_id, :locked, :active, :email, :secondary_email, :profile_id, :created_at, :updated_at
json.url user_url(user, format: :json)
