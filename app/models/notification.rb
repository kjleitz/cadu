class Notification < ApplicationRecord
  belongs_to :task
  belongs_to :receiver, class_name: User

  validates :content, :status, presence: true

  enum status: [:unseen, :seen, :dismissed]

  def view
    seen!
  end

  def dismiss
    dismissed!
  end

  def human_created_at
    created_at.strftime("%-I:%M %P %b %-d")
  end

  def self.viewing_order
    where.not(status: :seen).order(:created_at) + where(status: :seen).order(updated_at: :desc)
  end

end
