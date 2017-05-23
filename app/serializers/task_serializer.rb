class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :human_due_date, :status, :created_at, :idle, :requested, :accepted, :in_progress, :completed, :num_comments
  belongs_to :client, serializer: TaskClientSerializer
  has_many :comments
  has_many :labels
end
