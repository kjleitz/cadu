class Task < ApplicationRecord
  belongs_to :client, class: User
  has_many :notifications, :reminders, :comments, :labels_tasks
  has_many :labels, through: :labels_tasks

  enum status: [:idle, :requested, :accepted, :in_progress, :completed]

  def assistant
    client.assistant if status > 0
  end

end
