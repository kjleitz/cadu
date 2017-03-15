class Task < ApplicationRecord
  belongs_to :client, class_name: User
  delegate :assistant, to: :client
  has_many :notifications
  has_many :reminders
  has_many :comments
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks

  enum status: [:idle, :requested, :accepted, :in_progress, :completed]

  after_initialize :set_status_messages

  def set_status_messages
    STATUS_MESSAGES = {
      "idle"        => "A task titled '#{title}' has been created!",
      "requested"   => "#{client.name} requires assistance with '#{title}'.",
      "accepted"    => "Assistance request for '#{title}' has been accepted!",
      "in_progress" => "Work has begun on '#{title}'.",
      "completed"   => "#{assistant.name} has completed '#{title}'!"
    }
  end

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

  def status_message
    STATUS_MESSAGES[status]
  end

end
