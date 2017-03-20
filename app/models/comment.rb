class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :author, class_name: User

  validates :content, :pinned, :edited, presence: true

  alias_attribute :pinned?, :pinned
  alias_attribute :edited?, :edited

  after_update :set_edited

  def toggle_pin
    toggle(:pinned)
  end

  def human_created_at
    created_at.strftime("%-I:%M %P %A, %b %-d")
  end

  private

    def set_edited
      self.edited = true
    end
end
