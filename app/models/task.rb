class Task < ApplicationRecord
  belongs_to :client, class_name: User
  delegate :assistant, to: :client
  has_many :notifications
  has_many :reminders
  has_many :comments
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks

  validates :title, :content, :due_date, :status, presence: true

  enum status: [:idle, :requested, :accepted, :in_progress, :completed]

  def request_assistant
    requested!
    send_status_notification_to(assistant)
  end

  def accept
    accepted!
    send_status_notification_to(client)
  end

  def begin_work
    in_progress!
    send_status_notification_to(client)
  end

  def mark_complete
    completed!
    send_status_notification_to(client)
  end

  def send_status_notification_to(user)
    user.notify(self, status_message)
  end

  def status_message
    {
      "idle"        => "A task titled '#{title}' has been created!",
      "requested"   => "#{client.name} requires assistance with '#{title}'.",
      "accepted"    => "Assistance request for '#{title}' has been accepted!",
      "in_progress" => "Work has begun on '#{title}'.",
      "completed"   => "'#{title}' has been completed!"
    }[status]
  end

  def apply_label(label)
    labels << label unless labels.include?(label)
  end

end
