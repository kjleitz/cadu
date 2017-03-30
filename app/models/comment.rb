class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: User

  validates :content, presence: true

  alias_attribute :pinned?, :pinned
  alias_attribute :edited?, :edited

  after_update :set_edited

  default_scope { order(:created_at) }

  def audience
    author.client? ? task.assistant : task.client
  end

  def toggle_pin
    toggle(:pinned)
  end

  def human_created_at
    created_at.strftime("%A, %b %-d at %-I:%M %P")
  end

  private

    def set_edited
      self.edited = true
    end
end
