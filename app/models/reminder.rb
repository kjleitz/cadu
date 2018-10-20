class Reminder < ApplicationRecord
  belongs_to :client, class_name: 'User'
  delegate :assistant, to: :client
  belongs_to :task, optional: true

  validates :content, :status, presence: true

  enum status: [:unseen, :seen, :dismissed]

  scope :not_dismissed, -> { where.not(status: :dismissed).order(created_at: :desc) }
  scope :dismissed, -> { where(status: :dismissed).order(updated_at: :desc) }

  def view
    seen!
  end

  def dismiss
    dismissed!
  end

  def human_created_at
    created_at.strftime("%a, %b %-d - %-I:%M %P")
  end

end
