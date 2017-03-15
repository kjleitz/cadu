class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: User

  alias_attribute :pinned?, :pinned
  alias_attribute :edited?, :edited

end
