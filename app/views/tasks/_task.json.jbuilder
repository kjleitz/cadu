json.extract! task, :id, :content, :due_date, :user_id, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
