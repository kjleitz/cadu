class Task < ApplicationRecord
  belongs_to :client, class_name: User
  has_many :notifications
  has_many :reminders
  has_many :comments
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks

  enum status: [:idle, :requested, :accepted, :in_progress, :completed]

  def assistant
    client.assistant if requested?
  end

  # overrides #requested? from enum
  def requested?
    [:requested, :accepted, :in_progress].include?(status)
  end

end
