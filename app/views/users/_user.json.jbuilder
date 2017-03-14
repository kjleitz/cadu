json.extract! user, :id, :name, :email, :password_digest, :user_id, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
