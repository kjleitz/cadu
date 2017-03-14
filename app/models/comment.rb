class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class: User
end
