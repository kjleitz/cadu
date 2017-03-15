class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: User

  after_update :set_edited

  alias_attribute :pinned?, :pinned
  alias_attribute :edited?, :edited

  private

    def set_edited
      self.edited = true
    end
end
