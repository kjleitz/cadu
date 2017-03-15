class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: User

  alias :pinned? :pinned
  alias :edited? :edited

end
