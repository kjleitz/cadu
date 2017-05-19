class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :due_date, :status, :created_at
  belongs_to :client, serializer: TaskClientSerializer
  has_many :comments
end
