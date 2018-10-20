class Task < ApplicationRecord
  belongs_to :client, class_name: 'User'
  delegate :assistant, to: :client
  has_many :notifications, dependent: :destroy
  has_many :reminders, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :labels_tasks
  has_many :labels, through: :labels_tasks, dependent: :destroy

  validates :title, :content, :due_date, :status, presence: true

  STATUSES = [:idle, :requested, :accepted, :in_progress, :completed]
  enum status: STATUSES
  STATUSES.each { |state| alias_method state, :"#{state}?" }

  default_scope { order(:due_date) }

  def request_assistance
    requested!
    send_status_notification_to(assistant)
  end

  def accept
    accepted!
    send_status_notification_to(client)
  end

  def start
    in_progress!
    send_status_notification_to(client)
  end

  def mark_complete
    completed!
    send_status_notification_to(client)
  end

  def delegated?
    ["requested", "accepted", "in_progress"].include?(status)
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

  def labels_attributes=(label_attributes)
    names = label_attributes["0"]["name"].split(",").map(&:strip).reject(&:blank?)
    names.each { |name| apply_label(Label.find_or_create_by(name: name)) }
  end

  def label_ids=(ids)
    labels.clear
    ids.reject(&:blank?).each do |id|
      labels << Label.find(id) unless label_ids.include?(id)
    end
  end

  def num_comments
    comments.count
  end

end
