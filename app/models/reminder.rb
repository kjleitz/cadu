class Reminder < ApplicationRecord
  belongs_to :client, class_name: User
  delegate :assistant, to: :client
  belongs_to :task, optional: true

  validates :content, :status, presence: true

  enum status: [:unseen, :seen, :dismissed]

  def view
    seen!
  end

  def dismiss
    dismissed!
  end

  def human_created_at
    created_at.strftime("%a, %b %-d - %-I:%M %P")
  end

  def self.not_dismissed
    where.not(status: :dismissed)
  end
end
