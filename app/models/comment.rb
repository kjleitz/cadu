class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class: User

  alias :pinned? :pinned
  alias :edited? :edited
  
end
