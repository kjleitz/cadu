class Notification < ApplicationRecord
  belongs_to :task
  belongs_to :receiver, class_name: 'User'

  validates :content, :status, presence: true

  enum status: [:unseen, :seen, :dismissed]

  scope :unseen, -> { where(status: :unseen).order(created_at: :desc) }
  scope :seen, -> { where(status: :seen).order(updated_at: :desc) }
  scope :viewing_order, -> { unseen + seen }

  def view
    seen!
  end

  def dismiss
    dismissed!
  end

  def human_created_at
    created_at.strftime("%-I:%M %P %b %-d")
  end

end
