json.extract! comment, :id, :content, :task_id, :user_id, :pinned, :edited, :created_at, :updated_at
json.url comment_url(comment, format: :json)
