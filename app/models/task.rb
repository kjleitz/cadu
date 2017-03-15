class Task < ApplicationRecord
  belongs_to :client, class_name: User
  delegate :assistant, to: :client
  has_many :notifications
  has_many :reminders
  has_many :comments
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks

  enum status: [:idle, :requested, :accepted, :in_progress, :completed]

  def request_assistant
    requested!
  end

  def accept
    accepted!
  end

  def begin_work
    in_progress!
  end

  def mark_complete
    completed!
  end

end
