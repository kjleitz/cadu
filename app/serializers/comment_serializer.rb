class CommentSerializer < ActiveModel::Serializer
  attributes :id, :task_id, :content
  belongs_to :author, serializer: CommentAuthorSerializer
end
