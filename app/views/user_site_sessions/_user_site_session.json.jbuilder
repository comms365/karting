json.extract! user_site_session, :id, :lap_time, :weather, :session_date, :created_at, :updated_at
json.url user_site_session_url(user_site_session, format: :json)
