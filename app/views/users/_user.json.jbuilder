json.extract! user, :id, :username, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
