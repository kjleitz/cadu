class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :content, :receiver_id, :task_id, :status, :human_created_at
end
