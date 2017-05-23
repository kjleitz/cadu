class CommentSerializer < ActiveModel::Serializer
  attributes :id, :task_id, :human_created_at, :content
  belongs_to :author, serializer: CommentAuthorSerializer
end
