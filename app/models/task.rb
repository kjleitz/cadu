class Task < ApplicationRecord
  belongs_to :client, class_name: User
  delegate :assistant, to: :client
  has_many :notifications, dependent: :destroy
  has_many :reminders, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks, dependent: :destroy

  validates :title, :content, :due_date, :status, presence: true

  enum status: [:idle, :requested, :accepted, :in_progress, :completed]

  # Placeholder: I don't think this is necessary if I have a custom
  # #labels_attributes= writer method.
  # accepts_nested_attributes_for :labels

  def request_assistance
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

  def human_due_date
    due_date.strftime("%-I:%M %P %A, %b %-d")
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

  def labels_attributes=(labels_attributes)
    labels.clear
    labels_attributes.each do |label_attributes|
      apply_label(Label.find_or_create_by(label_attributes))
    end
  end

  def label_ids=(ids)
    labels.clear
    ids.reject(&:blank?).each do |id|
      labels << Label.find(id) unless label_ids.include?(id)
    end
  end

end
